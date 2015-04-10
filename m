From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Sat, 11 Apr 2015 01:05:26 +0300
Message-ID: <CANOLnOMJ9oy_VhxGDyg9yx8XLVSZPf51eycP7-j=r4KVF6RX-A@mail.gmail.com>
References: <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
	<5521A438.1070008@gmail.com>
	<CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
	<20150406151939.GG18048@atomide.com>
	<20150406154037.GI18048@atomide.com>
	<5522BEEF.2000405@gmail.com>
	<20150406174245.GJ18048@atomide.com>
	<CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
	<20150407022312.GK18048@atomide.com>
	<CANOLnOMyNesvA2nGC2uMnmYGLBQkU1dnfG1rBg1UWeGMrpHFzQ@mail.gmail.com>
	<20150409224446.GV18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33639 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbbDJWF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2015 18:05:28 -0400
Received: by layy10 with SMTP id y10so22548014lay.0
        for <linux-omap@vger.kernel.org>; Fri, 10 Apr 2015 15:05:26 -0700 (PDT)
In-Reply-To: <20150409224446.GV18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 10, 2015 at 1:44 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Grazvydas Ignotas <notasas@gmail.com> [150409 15:37]:
>> On Tue, Apr 7, 2015 at 5:23 AM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Matthijs van Duin <matthijsvanduin@gmail.com> [150406 11:15]:
>> >>
>> >> On 6 April 2015 at 19:42, Tony Lindgren <tony@atomide.com> wrote:
>> >> > Hmm but it still seems to do something also on cortex-a8 r3p2 t=
hat
>> >> > is supposedly not affected by 430973.. Based on my tests so far=
, at least
>> >> > armhf running cpuburn-a8 in the background and doing apt-get up=
date
>> >> > segfaults constantly without flush BTAC/BTB. This seems to be t=
he case
>> >> > no matter how the aux ctrl reg bits are set..
>> >>
>> >> That sounds.... really odd.  The TRM is fairly explicit about BTB
>> >> flush executing as nop when IBE is not set. Of course the TRM is =
not
>> >> exactly flawless, but still...
>> >
>> > Oops, sorry user error.. I was trying to clear IBE as a banked reg=
ister
>> > like L2 enable bit and of course it did not get cleared.. Clearing=
 it
>> > with a smc call really clears it. And in that case my test case se=
ems to
>> > work reliably on r3p2 without erratum 430973 enabled.
>>
>> May I ask how do you perform the smc call? I wanted to clear IBE too
>> to experiment, but it just hangs my board, even if I just write back
>> the same value. Here is what I do:
>>
>>         asm ("mrc p15, 0, %0, c1, c0, 1" : "=3Dr"(val));
>>
>>         asm (".arch_extension sec\n\t"
>>              "mov r0,  %0\n"
>>              "mov r12, #3\n"
>>              "smc #0\n"
>>              :: "r"(val) : "r0", "r12");
>>
>> I just run this from a sysfs write handler, does it need to be run o=
n
>> SRAM or something?
>
> Best done in the bootloader.. I just hacked it into the restore from
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
>         ldr     r4, scratchpad_base
>         ldr     r3, [r4,#0xBC]
>         ldr     r0, [r3,#4]
> +       bic     r0, r1, #(1 << 6)

Hmm did you mean r0 instead of r1 here? I hope your test results
didn't come from some other random bit from r1 being written to
aux_ctrl.
And according to readback this doesn't seem to work for me, even when
my board has idle working. Or is it not supposed to be visible in
readback?

Anyway I've managed to clear that damn bit in the bootloader, but
failed to measure any performance impact from clearing this bit and
getting rid of BTB flush mcr in cpu_v7_switch_mm() (this is on DM3730
with r3p2 A8). My test was to simply run 2 processes that would spin a
counter (running more processes doesn't seem to increase context
switches per second, so running 2 seemed enough).


Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
