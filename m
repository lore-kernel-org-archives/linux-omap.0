From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: Build failure with verify size in next-20171102
Date: Fri, 3 Nov 2017 08:22:51 +0000
Message-ID: <CAKv+Gu_E66aC7iLcqtszpx2yYSC1eskQ3JAm4QXAPhTPBw7nhQ@mail.gmail.com>
References: <20171102193027.GB28152@atomide.com>
 <20171102232038.GA28231@n2100.armlinux.org.uk>
 <20171102234309.GE28152@atomide.com>
 <20171103000437.GB28231@n2100.armlinux.org.uk>
 <20171103001437.GC28231@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171103001437.GC28231@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 3 November 2017 at 00:14, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Nov 03, 2017 at 12:04:37AM +0000, Russell King - ARM Linux wrote:
>> On Thu, Nov 02, 2017 at 04:43:09PM -0700, Tony Lindgren wrote:
>> > * Russell King - ARM Linux <linux@armlinux.org.uk> [171102 23:22]:
>> > > On Thu, Nov 02, 2017 at 12:30:27PM -0700, Tony Lindgren wrote:
>> > > > Hi Russeell,
>> > > >
>> > > > I think you're already aware of the build failure caused by commit
>> > > > 078c0927485e ("ARM: verify size of zImage"), but here's info just
>> > > > in case.
>> > > >
>> > > > arm-unknown-linux-musleabi-ld.bfd: error: zImage file size is incorrect
>> > > > make[2]: *** [arch/arm/boot/compressed/Makefile:185: arch/arm/boot/compressed/vmlinux] Error 1
>> > > > make[1]: *** [arch/arm/boot/Makefile:64: arch/arm/boot/compressed/vmlinux] Error 2
>> > > > make: *** [arch/arm/Makefile:335: zImage] Error 2
>> > > >
>> > > > Other than that I was surprised that next actually booted for me
>> > > > after a few week break with Linux next! :)
>> > >
>> > > It would be nice if people can investigate why that happens - I'm
>> > > completely unable to reproduce it locally, even if I link using
>> > > the same vmlinux.lds file and the objects from someone who sees the
>> > > failure.
>> > >
>> > > There's some binutils version specific stuff that's going on here.
>> > >
>> > > What I have in my current for-next, which I'm intending to push,
>> > > is all the same patches except the patch that introduces the above
>> > > check is subsituted by a patch that produces an extra _edata_real
>> > > symbol.  This _should_ match _edata.  So, if you hit this failure,
>> > > try either my current for-next branch or tomorrow's linux-next, and
>> > > run arm-linux-nm on arch/arm/boot/compressed/vmlinux and check the
>> > > addresses given for _edata and _edata_real.
>> >
>> > OK thanks reverting 078c0927485e and applying dad4675388fc ("ARM:
>> > add debug ".edata_real" symbol") from your for-next branch builds
>> > and boots for me.
>> >
>> > > Theory says they should be identical, but the failure of that assert
>> > > could only happen if "." inside the output section was different from
>> > > _edata assigned outside.  _edata_real is now the address of "." inside
>> > > the output section.
>> >
>> > With 078c0927485e reverted and dad4675388fc applied they are
>> > identical for me:
>> >
>> > $ ${armcompiler}nm arch/arm/boot/compressed/vmlinux | grep _edata
>> > 00421960 D _edata
>> > 00421960 D _edata_real
>> >
>> > Let me know if you want me to run some test with the failing
>> > commit also.
>>
>> So:
>>
>>   .image_end (NOLOAD) : {
>>      ASSERT(. == _edata, "...");
>>   }
>>
>> fails, because . != _edata, but:
>>
>>   .image_end (NOLOAD) : {
>>      _edata_real = .;
>>   }
>>
>> produces an image where _edata_real == _edata.
>>
>> That's completely insane and illogical.  *Shrug*.  God knows what's
>> going on there.
>
> Reading through the "ld" documentation for ".":
>
>      Note: '.' actually refers to the byte offset from the start of the
>   current containing object.  Normally this is the 'SECTIONS' statement,
>   whose start address is 0, hence '.' can be used as an absolute address.
>   If '.' is used inside a section description however, it refers to the
>   byte offset from the start of that section, not an absolute address.
>
> If that _were_ true, then _edata_real should be zero, because it's
> used inside a section description and it should be the "byte offset
> from the start of that section, not an absolute address".  It isn't.
> So, this documentation is blatently wrong and misleading.  In fact,
> we use this fact that "." refers to the virtual address in the generic
> parts of the linker script.
>
> I don't think we can trust anything the ld documentation says about "."
> and by extension, I don't think we can trust ld's behaviour in how "."
> behaves.
>
> Quite where we go from here, I've no idea, because I don't see how we
> can trust the linker's behaviour with linker scripts.
>

Could we try moving the ASSERT after the section, and using

ASSERT(ADDR(.image_end) == _edata, "...");

instead?
