From: Nishanth Menon <nm@ti.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Thu, 9 Apr 2015 18:44:08 -0500
Message-ID: <55270EC8.2080900@ti.com>
References: <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com> <5521A438.1070008@gmail.com> <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com> <20150406151939.GG18048@atomide.com> <20150406154037.GI18048@atomide.com> <5522BEEF.2000405@gmail.com> <20150406174245.GJ18048@atomide.com> <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com> <20150407022312.GK18048@atomide.com> <CANOLnOMyNesvA2nGC2uMnmYGLBQkU1dnfG1rBg1UWeGMrpHFzQ@mail.gmail.com> <20150409224446.GV18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791AbbDIXqn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 19:46:43 -0400
In-Reply-To: <20150409224446.GV18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/09/2015 05:44 PM, Tony Lindgren wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [150409 15:37]:
>> On Tue, Apr 7, 2015 at 5:23 AM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Matthijs van Duin <matthijsvanduin@gmail.com> [150406 11:15]:
>>>>
>>>> On 6 April 2015 at 19:42, Tony Lindgren <tony@atomide.com> wrote:
>>>>> Hmm but it still seems to do something also on cortex-a8 r3p2 that
>>>>> is supposedly not affected by 430973.. Based on my tests so far, at least
>>>>> armhf running cpuburn-a8 in the background and doing apt-get update
>>>>> segfaults constantly without flush BTAC/BTB. This seems to be the case
>>>>> no matter how the aux ctrl reg bits are set..
>>>>
>>>> That sounds.... really odd.  The TRM is fairly explicit about BTB
>>>> flush executing as nop when IBE is not set. Of course the TRM is not
>>>> exactly flawless, but still...
>>>
>>> Oops, sorry user error.. I was trying to clear IBE as a banked register
>>> like L2 enable bit and of course it did not get cleared.. Clearing it
>>> with a smc call really clears it. And in that case my test case seems to
>>> work reliably on r3p2 without erratum 430973 enabled.
>>
>> May I ask how do you perform the smc call? I wanted to clear IBE too
>> to experiment, but it just hangs my board, even if I just write back
>> the same value. Here is what I do:
>>
>>         asm ("mrc p15, 0, %0, c1, c0, 1" : "=r"(val));
>>
>>         asm (".arch_extension sec\n\t"
>>              "mov r0,  %0\n"
>>              "mov r12, #3\n"
>>              "smc #0\n"
>>              :: "r"(val) : "r0", "r12");
>>
>> I just run this from a sysfs write handler, does it need to be run on
>> SRAM or something?
> 
> Best done in the bootloader.. I just hacked it into the restore from

I recently did that in u-boot:

http://git.denx.de/?p=u-boot.git;a=commitdiff;h=5902f4ce0f2bd1411e40dc0ece3598a0fc19b2ae

http://git.denx.de/?p=u-boot.git;a=blob;f=arch/arm/cpu/armv7/omap3/board.c;h=b064c0cc834356b33e14e0f36774108fa6a6c580;hb=HEAD#l428

I believe it should be scalable to other SoCs as well (weak function
that may be overriden as needed). Hope that helps.

> off-idle to test, see below. But for that you naturally need to have
> a device with working idle and it's usable for just testing for lazy
> people.
> 
> Regards,
> 
> Tony
> 
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -516,6 +516,7 @@ l2_inv_gp:
>  	ldr	r4, scratchpad_base
>  	ldr	r3, [r4,#0xBC]
>  	ldr	r0, [r3,#4]
> +	bic	r0, r1, #(1 << 6)
>  	mov	r12, #0x3
>  	smc	#0			@ Call SMI monitor (smieq)
>  	ldr	r4, scratchpad_base
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Regards,
Nishanth Menon
