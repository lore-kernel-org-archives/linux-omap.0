From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 1/4] OMAP3: PM debug: remove sleep_while_idle feature
Date: Fri, 27 May 2011 09:37:19 +0200
Message-ID: <BANLkTimnt4-8hKuX+Lgd9PH1bu6e6jK+Hw@mail.gmail.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46591 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab1E0HhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 03:37:20 -0400
Received: by qwk3 with SMTP id 3so733522qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 00:37:20 -0700 (PDT)
In-Reply-To: <1306450971-27732-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On Fri, May 27, 2011 at 1:02 AM, Kevin Hilman <khilman@ti.com> wrote:
> Remove the OMAP-specific PM debug 'sleep_while_idle' feature which is
> currently available as an OMAP-specific debugfs entry.
>
> This duplicates existing ARM-generic functionality available as a
> boot-time option using the boot cmdline option 'hohlt'.
'nohlt' is only for the default arch idle handler (pm_idle). It does
not apply to the cpuidle handler (omap3_enter_idle) which depends on
CONFIG_CPU_IDLE.

> If runtime configuration of this is needed, then adding a debugfs
> entry for the ARM-generic hlt/nohlt interface should be added.
Is there a need for it?

Regards,
Jean
