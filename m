From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 0/4] OMAP: cpuidle code clean-up
Date: Wed, 18 May 2011 16:38:04 +0200
Message-ID: <871uzwt6pf.fsf@ti.com>
References: <1304935336-6308-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:33732 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752856Ab1EROit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 10:38:49 -0400
Received: by mail-wy0-f169.google.com with SMTP id 19so1523195wyf.0
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 07:38:46 -0700 (PDT)
In-Reply-To: <1304935336-6308-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Mon, 9 May 2011 12:02:12 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Rework of the OMAP2+ cpuidle code

Excellent work!  Thanks.

Queuing for 2.6.40 (branch: for_2.6.40/pm-cleanup)

Kevin

> v3: rework after comments on linux-omap ML:
> - renamed the C-state driver data variables as 'cx',
> - retain C1 as the only always valid state and safe state,
> - rework of the C-states definition.
>
> v2: rework after comments on linux-omap ML:
> - remove useless macros,
> - replace the C-state common data fill-in helper macro by an inline
>    function, for better readability,
> - update commits description.
>
> v1:
> - optimize the cpuidle C-states data registration and storage,
> - change the interaction with the debugfs 'enable_off_mode' knob
>  and the use of the C-states 'valid' internal field,
> - remove dead code,
> - improve code readability.
>
> Tested on Beagleboard B5 with cpuidle in RET and OFF modes.
>
> Another 151 lines of OMAP code gone ;p
>
> Notes:
> 1) the debugfs 'enable_off_mode' knob will be deprecated by the use
>  of the devices constraints framework to restrict the power domains
>  power modes.
> 2) the MPU and CORE power domains low power modes are controlled
>  by cpuidle, based on the allowed overall sleep+wake-up latencies
>  and the wake-up latency constraints on the MPU. This is incorrect.
>  The devices constraints framework shall be used instead to control
>  all power domains.
>
> ToDo:
> - integrate cpuidle with the devices constraints framework, when merged in,
> - refine the latency figures and express them in term of available data
>  from other frameworks (OMAP PM, constaints framework, omap_devices,
>  new VC/VP voltage and DVFS code ...),
>
> Rebased on khilman's for_2.6.40/pm-cleanup branch
>
>
> Jean Pihet (4):
>   OMAP3: clean-up mach specific cpuidle data structures
>   OMAP3: cpuidle: re-organize the C-states data
>   OMAP3: cpuidle: code rework for improved readability
>   OMAP3: cpuidle: change the power domains modes determination logic
>
>  arch/arm/mach-omap2/board-rx51.c  |   18 +-
>  arch/arm/mach-omap2/cpuidle34xx.c |  436 +++++++++++++------------------------
>  arch/arm/mach-omap2/pm.h          |   17 +-
>  arch/arm/mach-omap2/pm34xx.c      |   12 -
>  4 files changed, 166 insertions(+), 317 deletions(-)
