From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 1/4] OMAP3: PM debug: remove sleep_while_idle feature
Date: Fri, 27 May 2011 08:26:03 -0700
Message-ID: <87vcww412s.fsf@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-2-git-send-email-khilman@ti.com>
	<BANLkTimnt4-8hKuX+Lgd9PH1bu6e6jK+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59646 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752380Ab1E0P0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 11:26:07 -0400
Received: by mail-px0-f174.google.com with SMTP id 15so1041682pxi.5
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 08:26:05 -0700 (PDT)
In-Reply-To: <BANLkTimnt4-8hKuX+Lgd9PH1bu6e6jK+Hw@mail.gmail.com> (Jean
	Pihet's message of "Fri, 27 May 2011 09:37:19 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Fri, May 27, 2011 at 1:02 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Remove the OMAP-specific PM debug 'sleep_while_idle' feature which is
>> currently available as an OMAP-specific debugfs entry.
>>
>> This duplicates existing ARM-generic functionality available as a
>> boot-time option using the boot cmdline option 'hohlt'.
> 'nohlt' is only for the default arch idle handler (pm_idle). It does
> not apply to the cpuidle handler (omap3_enter_idle) which depends on
> CONFIG_CPU_IDLE.

AFAICT, it affects CPUidle also, since CPUidle replaces pm_idle, which
is protected by the hlt_counter check.

I think the CPUidle folks are looking for a way to replace using
pm_idle though.  After that happens, there are a couple options.  1) add
a check for hlt_counter in the CPUidle path, or 2) just disable CPUidle
at Kconfig level.

>> If runtime configuration of this is needed, then adding a debugfs
>> entry for the ARM-generic hlt/nohlt interface should be added.
> Is there a need for it?

I don't think so.    But my point was that if anyone wants this feature
back, this would be the way to add it.

Kevin

