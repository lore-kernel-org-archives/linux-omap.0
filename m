From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Build failure with verify size in next-20171102
Date: Fri, 3 Nov 2017 00:04:37 +0000
Message-ID: <20171103000437.GB28231@n2100.armlinux.org.uk>
References: <20171102193027.GB28152@atomide.com>
 <20171102232038.GA28231@n2100.armlinux.org.uk>
 <20171102234309.GE28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171102234309.GE28152@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 02, 2017 at 04:43:09PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [171102 23:22]:
> > On Thu, Nov 02, 2017 at 12:30:27PM -0700, Tony Lindgren wrote:
> > > Hi Russeell,
> > > 
> > > I think you're already aware of the build failure caused by commit
> > > 078c0927485e ("ARM: verify size of zImage"), but here's info just
> > > in case.
> > > 
> > > arm-unknown-linux-musleabi-ld.bfd: error: zImage file size is incorrect
> > > make[2]: *** [arch/arm/boot/compressed/Makefile:185: arch/arm/boot/compressed/vmlinux] Error 1
> > > make[1]: *** [arch/arm/boot/Makefile:64: arch/arm/boot/compressed/vmlinux] Error 2
> > > make: *** [arch/arm/Makefile:335: zImage] Error 2
> > > 
> > > Other than that I was surprised that next actually booted for me
> > > after a few week break with Linux next! :)
> > 
> > It would be nice if people can investigate why that happens - I'm
> > completely unable to reproduce it locally, even if I link using 
> > the same vmlinux.lds file and the objects from someone who sees the
> > failure.
> > 
> > There's some binutils version specific stuff that's going on here.
> > 
> > What I have in my current for-next, which I'm intending to push,
> > is all the same patches except the patch that introduces the above
> > check is subsituted by a patch that produces an extra _edata_real
> > symbol.  This _should_ match _edata.  So, if you hit this failure,
> > try either my current for-next branch or tomorrow's linux-next, and
> > run arm-linux-nm on arch/arm/boot/compressed/vmlinux and check the
> > addresses given for _edata and _edata_real.
> 
> OK thanks reverting 078c0927485e and applying dad4675388fc ("ARM:
> add debug ".edata_real" symbol") from your for-next branch builds
> and boots for me.
> 
> > Theory says they should be identical, but the failure of that assert
> > could only happen if "." inside the output section was different from
> > _edata assigned outside.  _edata_real is now the address of "." inside
> > the output section.
> 
> With 078c0927485e reverted and dad4675388fc applied they are
> identical for me:
> 
> $ ${armcompiler}nm arch/arm/boot/compressed/vmlinux | grep _edata
> 00421960 D _edata
> 00421960 D _edata_real
> 
> Let me know if you want me to run some test with the failing
> commit also.

So:

  .image_end (NOLOAD) : {
     ASSERT(. == _edata, "...");
  }

fails, because . != _edata, but:

  .image_end (NOLOAD) : {
     _edata_real = .;
  }

produces an image where _edata_real == _edata.

That's completely insane and illogical.  *Shrug*.  God knows what's
going on there.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
