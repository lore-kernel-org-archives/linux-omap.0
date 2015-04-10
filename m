From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Fri, 10 Apr 2015 16:08:14 -0700
Message-ID: <20150410230814.GX18048@atomide.com>
References: <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
 <20150407022312.GK18048@atomide.com>
 <CANOLnOMyNesvA2nGC2uMnmYGLBQkU1dnfG1rBg1UWeGMrpHFzQ@mail.gmail.com>
 <20150409224446.GV18048@atomide.com>
 <CANOLnOMJ9oy_VhxGDyg9yx8XLVSZPf51eycP7-j=r4KVF6RX-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:43573 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755125AbbDJXLs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Apr 2015 19:11:48 -0400
Content-Disposition: inline
In-Reply-To: <CANOLnOMJ9oy_VhxGDyg9yx8XLVSZPf51eycP7-j=r4KVF6RX-A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Grazvydas Ignotas <notasas@gmail.com> [150410 15:06]:
> On Fri, Apr 10, 2015 at 1:44 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Grazvydas Ignotas <notasas@gmail.com> [150409 15:37]:
> >> On Tue, Apr 7, 2015 at 5:23 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Matthijs van Duin <matthijsvanduin@gmail.com> [150406 11:15]:
> >> >>
> >> >> On 6 April 2015 at 19:42, Tony Lindgren <tony@atomide.com> wrote:
> >> >> > Hmm but it still seems to do something also on cortex-a8 r3p2 that
> >> >> > is supposedly not affected by 430973.. Based on my tests so far, at least
> >> >> > armhf running cpuburn-a8 in the background and doing apt-get update
> >> >> > segfaults constantly without flush BTAC/BTB. This seems to be the case
> >> >> > no matter how the aux ctrl reg bits are set..
> >> >>
> >> >> That sounds.... really odd.  The TRM is fairly explicit about BTB
> >> >> flush executing as nop when IBE is not set. Of course the TRM is not
> >> >> exactly flawless, but still...
> >> >
> >> > Oops, sorry user error.. I was trying to clear IBE as a banked register
> >> > like L2 enable bit and of course it did not get cleared.. Clearing it
> >> > with a smc call really clears it. And in that case my test case seems to
> >> > work reliably on r3p2 without erratum 430973 enabled.
> >>
> >> May I ask how do you perform the smc call? I wanted to clear IBE too
> >> to experiment, but it just hangs my board, even if I just write back
> >> the same value. Here is what I do:
> >>
> >>         asm ("mrc p15, 0, %0, c1, c0, 1" : "=r"(val));
> >>
> >>         asm (".arch_extension sec\n\t"
> >>              "mov r0,  %0\n"
> >>              "mov r12, #3\n"
> >>              "smc #0\n"
> >>              :: "r"(val) : "r0", "r12");
> >>
> >> I just run this from a sysfs write handler, does it need to be run on
> >> SRAM or something?
> >
> > Best done in the bootloader.. I just hacked it into the restore from
> > off-idle to test, see below. But for that you naturally need to have
> > a device with working idle and it's usable for just testing for lazy
> > people.
> >
> > Regards,
> >
> > Tony
> >
> > --- a/arch/arm/mach-omap2/sleep34xx.S
> > +++ b/arch/arm/mach-omap2/sleep34xx.S
> > @@ -516,6 +516,7 @@ l2_inv_gp:
> >         ldr     r4, scratchpad_base
> >         ldr     r3, [r4,#0xBC]
> >         ldr     r0, [r3,#4]
> > +       bic     r0, r1, #(1 << 6)
> 
> Hmm did you mean r0 instead of r1 here? I hope your test results
> didn't come from some other random bit from r1 being written to
> aux_ctrl.

Oh right sorry, yeah it should be r0 above. Luck based coding :)

> And according to readback this doesn't seem to work for me, even when
> my board has idle working. Or is it not supposed to be visible in
> readback?

Hmm I've verified between apps segfaulting depending on how bit 6
is set on r3p2.

Anyways, did a retry just in case, below is an updated test patch.
For me aux ctrl changes after enabling idle stuff:

aux ctrl: 0x000000e2
...
aux ctrl: 0x000000a2

Did you enable the UART timeout etc so it really hits off mode
when testing?
 
> Anyway I've managed to clear that damn bit in the bootloader, but
> failed to measure any performance impact from clearing this bit and
> getting rid of BTB flush mcr in cpu_v7_switch_mm() (this is on DM3730
> with r3p2 A8). My test was to simply run 2 processes that would spin a
> counter (running more processes doesn't seem to increase context
> switches per second, so running 2 seemed enough).

Well that's a good test result :) It means it's OK to keep the
430973 enabled without a performance impatct.

Regards,

Tony

8< -----------------
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -93,6 +93,7 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
 	int i;
+	u32 val;
 
 	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
 		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
@@ -116,6 +117,9 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 
 	seq_printf(s, "\n");
 
+	asm ("mrc p15, 0, %0, c1, c0, 1" : "=r"(val));
+	seq_printf(s, "aux ctrl: 0x%08x\n", val);
+
 	return 0;
 }
 
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -516,6 +516,7 @@ l2_inv_gp:
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	ldr	r0, [r3,#4]
+	bic	r0, r0, #(1 << 6)
 	mov	r12, #0x3
 	smc	#0			@ Call SMI monitor (smieq)
 	ldr	r4, scratchpad_base
