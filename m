From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Fri, 20 Aug 2010 09:56:50 +0300
Message-ID: <20100820065649.GH25742@atomide.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
 <20100813080200.18750.37791.stgit@baageli.muru.com>
 <4C651635.8000201@ru.mvista.com>
 <20100813102933.GN12706@atomide.com>
 <4C65238D.9080105@ru.mvista.com>
 <87sk2ao4fr.fsf@deeprootsystems.com>
 <4C6D7936.3090201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ulDeV4rPMk/y39in"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56871 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab0HTG4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 02:56:54 -0400
Content-Disposition: inline
In-Reply-To: <4C6D7936.3090201@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Sergei Shtylyov <sshtylyov@mvista.com> [100819 21:27]:
> Hello.
> 
> Kevin Hilman wrote:
> 
> >>>>>From: Kevin Hilman <khilman@ti.com>
> >>>>>Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> >>>>>mistakenly removed the check for PER when disabling the IO chain.
> >>>>>During idle, if the PER powerdomain transitions and CORE does not (as
> 
> >>>>  Does not what?
> 
> >>>How about ".. and CORE does not transition"?
> 
> >>   Transition to what then? Sentense till won't parse right...
> 
> >>>Kevin, care to clarify that?
> >>   Yeah, looks like a considerable partt of that sentense got omitted...
> 
> >No.  Nothing was omitted.
> 
> >It's like saying "Tony drinks Fernet and Kevin does not."  Adding an
> >additional "drinks Fernet" at the end is redundant.
> 
>    Sorry, the sentence still doesn't parse for me. You don't say
> "Fernet" there BTW, so it's not clear where the PER powerdomain
> transitions to. What goes after the closing parenthesis doesn't
> clear things up either, it just describes what happens if...

I'll update it with the following to preserve the Fernet style,
and to describe the transition:

During idle, if the PER powerdomain transitions into a lower state
and CORE does not, the IO pad wakeups are not being disabled in
the idle path after they are enabled. This can happen with the
lower C-states when using CPUidle for example.

Updated patch attached.

Please reply ASAP if this is not OK, I'd like to get a pull
request for these fixes sent to Linus over the weekend.

Regards,

Tony

--ulDeV4rPMk/y39in
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap3-pm-ensure-io-wakeups-are-properly-disabled.patch"

From: Kevin Hilman <khilman@ti.com>
Date: Mon, 16 Aug 2010 09:21:19 +0300
Subject: [PATCH] OMAP3: PM: ensure IO wakeups are properly disabled

Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
mistakenly removed the check for PER when disabling the IO chain.

During idle, if the PER powerdomain transitions into a lower state
and CORE does not, the IO pad wakeups are not being disabled in
the idle path after they are enabled. This can happen with the
lower C-states when using CPUidle for example.

This patch ensures that the check for disabling IO wakeups also checks
for PER transitions, matching the check done to enable IO wakeups.

Found when debugging PM/CPUidle related problems reported by Ameya
Palande <ameya.palande@nokia.com>.  Problems were triggered
particularily on boards with UART2 consoles (n900, Overo) since UART2
is in the PER powerdomain.

Tested on l-o master (omap3_defonfig + CONFIG_CPU_IDLE=y) as well
as with current PM branch.  Boards tested: n900, Overo, omap3evm.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Ameya Palande <ameya.palande@nokia.com>
Tested-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
[tony@atomide.com: updated description to clarify the transistion]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fb4994a..7b03426 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -480,7 +480,9 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
+	if (omap3_has_io_wakeup() &&
+	    (per_next_state < PWRDM_POWER_ON ||
+	     core_next_state < PWRDM_POWER_ON)) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}

--ulDeV4rPMk/y39in--
