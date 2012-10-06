From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP
 mode
Date: Sat, 06 Oct 2012 12:18:23 +0200
Message-ID: <6d3553bfe8a2d1ac88cab852100616a7@localhost>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_34c344971ff8e889eaf1f2717d707cf3"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121005200822.GQ3874@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

--=_34c344971ff8e889eaf1f2717d707cf3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8

Hi Tony,

On Fri, 5 Oct 2012 13:08:22 -0700, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
> 
> * Marc Zyngier <marc.zyngier@arm.com> [120907 10:04]:
>> From: Dave Martin <dave.martin@linaro.org>
>> 
>> This patch does two things:
>> 
>>   * Ensure that asynchronous aborts are masked at kernel entry.
>>     The bootloader should be masking these anyway, but this reduces
>>     the damage window just in case it doesn't.
>> 
>>   * Enter svc mode via exception return to ensure that CPU state is
>>     properly serialised.  This does not matter when switching from
>>     an ordinary privileged mode ("PL1" modes in ARMv7-AR rev C
>>     parlance), but it potentially does matter when switching from a
>>     another privileged mode such as hyp mode.
>> 
>> This should allow the kernel to boot safely either from svc mode or
>> hyp mode, even if no support for use of the ARM Virtualization
>> Extensions is built into the kernel.
>> 
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Just bisected this down in linux-next for breaking booting of
> my omap2420 ARMv6 based n8x0..
> 
>> --- a/arch/arm/kernel/head.S
>> +++ b/arch/arm/kernel/head.S
>> @@ -83,8 +83,12 @@ ENTRY(stext)
>>   THUMB(	.thumb			)	@ switch to Thumb now.
>>   THUMB(1:			)
>>  
>> -	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
>> -						@ and irqs disabled
>> +#ifdef CONFIG_ARM_VIRT_EXT
>> +	bl	__hyp_stub_install
>> +#endif
>> +	@ ensure svc mode and all interrupts masked
>> +	safe_svcmode_maskall r9
>> +
>>  	mrc	p15, 0, r9, c0, c0		@ get processor id
>>  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
>>  	movs	r10, r5				@ invalid processor (r5=0)?
> 
> ..and looks like undoing this part fixes it. Any ideas?
> 
> I quickly tried disabling ARCH_OMAP3 and ARCH_OMAP4 so it's
> ARMv6 but that does not help.

If you compiled for v6 only, we can safely exclude __hyp_stub_install, and
I assume that you get past the decompressor.

If so, that indicates some side effect of the safe_svcmode_maskall macro,
and I suspect the "movs pc, lr" bit.

Can you try the attached patch? It basically falls back to the previous
behaviour if not entered in HYP mode.

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.
--=_34c344971ff8e889eaf1f2717d707cf3
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=us-ascii; charset=UTF-8;
 name=setmode.patch
Content-Disposition: attachment;
 filename=setmode.patch

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2Fzc2VtYmxlci5oIGIvYXJjaC9hcm0v
aW5jbHVkZS9hc20vYXNzZW1ibGVyLmgKaW5kZXggNjU4YTE1ZC4uYjIxYjk3ZiAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vYXNzZW1ibGVyLmgKKysrIGIvYXJjaC9hcm0vaW5jbHVk
ZS9hc20vYXNzZW1ibGVyLmgKQEAgLTI1NCwxNiArMjU0LDE3IEBACiAJbW92CWxyICwgXHJlZwog
CWFuZAlsciAsIGxyICwgI01PREVfTUFTSwogCWNtcAlsciAsICNIWVBfTU9ERQotCW9ycglccmVn
ICwgXHJlZyAsICNQU1JfQV9CSVQgfCBQU1JfSV9CSVQgfCBQU1JfRl9CSVQKKwlvcnIJXHJlZyAs
IFxyZWcgLCAjUFNSX0lfQklUIHwgUFNSX0ZfQklUCiAJYmljCVxyZWcgLCBccmVnICwgI01PREVf
TUFTSwogCW9ycglccmVnICwgXHJlZyAsICNTVkNfTU9ERQogVEhVTUIoCW9ycglccmVnICwgXHJl
ZyAsICNQU1JfVF9CSVQJKQotCW1zcglzcHNyX2N4c2YsIFxyZWcKLQlhZHIJbHIsIEJTWU0oMmYp
CiAJYm5lCTFmCisJb3JyCVxyZWcsIFxyZWcsICNQU1JfQV9CSVQKKwlhZHIJbHIsIEJTWU0oMmYp
CisJbXNyCXNwc3JfY3hzZiwgXHJlZwogCV9fTVNSX0VMUl9IWVAoMTQpCiAJX19FUkVUCi0xOglt
b3ZzCXBjLCBscgorMToJbXNyCWNwc3JfYywgXHJlZwogMjoKIC5lbmRtCiAK
--=_34c344971ff8e889eaf1f2717d707cf3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=_34c344971ff8e889eaf1f2717d707cf3--
