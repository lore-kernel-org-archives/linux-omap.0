From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/05] OMAP3: CPUidle driver
Date: Thu, 09 Oct 2008 16:27:17 +0300
Message-ID: <87prm9ucei.fsf@deeprootsystems.com>
References: <001601c9293d$79bd4200$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:38275 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758239AbYJIN10 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 09:27:26 -0400
Received: by nf-out-0910.google.com with SMTP id d3so10065nfc.21
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2008 06:27:25 -0700 (PDT)
In-Reply-To: <001601c9293d$79bd4200$LocalHost@wipultra1382> (Rajendra Nayak's message of "Wed\, 8 Oct 2008 17\:30\:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch set implements Cpuidle driver for OMAP3 platforms. It is
> validated on the 3430SDP (using the omap_3430sdp_min_defconfig) and
> applies on the pm-20081006 branch.

Excellent.  Thank you.  I'll pull into pm-20081006 today.

One question: You have C6 to hit chip-off, but it is never enabled.
Has this been tested?  Enabling it allows me to hit chip OFF, but it
never comes back from OFF-mode.  I will push some patches to make this
work with /sys/power/enable_off_mode.

Some minor problems that I will fixup when rebasing to the next pm
branch:

 - You removed C0, but all the comments still refer to it
 - /sys/power/enable_off_mode doesn't affect off-mode states
   in CPUidle

patch 1:
 - I still don't like the #ifdefs for the init sequence.

patch 2:
 - checkpatch warning

Kevin

> The following C states are defined and used 
>
>  *      C0 . System executing code (Not an idle state)
>  *      C1 . MPU WFI + Core active
>  *      C2 . MPU CSWR + Core active
>  *      C3 . MPU OFF + Core active
>  *      C4 . MPU CSWR + Core CSWR
>  *      C5 . MPU OFF + Core CSWR
>  *      C6 . MPU OFF + Core OFF
>
> CPUidle support is not enabled by default in any of the defconfigs and hence has to enabled seperately 
> if you plan to test these patches.
>
> CPUIdle ---> [*] CPU idle PM support
>
> regards,
> Rajendra
