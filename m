From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Sat, 19 May 2012 12:52:37 +0300
Message-ID: <20120519095237.GA26761@besouro>
References: <1337365122-702-1-git-send-email-nm@ti.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43838 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752877Ab2ESJwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 May 2012 05:52:55 -0400
Received: by lbbgj10 with SMTP id gj10so3425455lbb.37
        for <linux-omap@vger.kernel.org>; Sat, 19 May 2012 02:52:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337365122-702-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Wenbiao Wang <wwang@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Minor suggestion.

On Fri, May 18, 2012 at 01:18:41PM -0500, ext Nishanth Menon wrote:
> From: Wenbiao Wang <wwang@ti.com>
> 
> Voltage Processor state machine transition to disable need to
> occur from IDLE state. When we transition OPP in a functioning
> system, the call sequence for an OPP transition is as follows:
> omap_sr_disable
>       -> sr class 3 disable
>            -> vp disable
>            -> sr disable
> forceupdate to voltage/frequency scale depending on which OPP
> we are transitioning to.
> 
> If we hit a critical timing window where SR had commanded VP
> for a voltage transition and VP is in the middle of operating
> on that command, it needs to go through a few states before
> going to update state(where it actually sends the command to
> VC). Initial view of h/w owners is that the state disable of VP
> is expected to be sampled for the next transition.
> 
> Instead, to be on a safer side, we ensure that the valid states
> of the VP state machine is diligently followed by software. This
> can be done by waiting for VP to be in idle  prior to disabling
> VP. Existing prints have been updated to ensure context is
> available on error messages.
> 
> As part of this change, increase timeout for VP idle check to
> improbable 500uSec to be certain that system is indeed unable
> to continue before crashing out with error(worst case expectancy
> remains the same 3-100uSec depending on when we caught VP).
> 


<cut>

>  
>  /* XXX document */
> -#define VP_IDLE_TIMEOUT		200
> +#define VP_IDLE_TIMEOUT		500

I guess it is time to properly document this increasing busy loop delay..
As it is getting closer to ms scale..

>  #define VP_TRANXDONE_TIMEOUT	300
>  
>  /**
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
