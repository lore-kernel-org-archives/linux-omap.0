From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde support
Date: Wed, 02 Mar 2011 15:46:10 -0800
Message-ID: <87oc5txf0d.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37914 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab1CBXqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 18:46:16 -0500
Received: by mail-yw0-f45.google.com with SMTP id 41so200999ywl.18
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 15:46:13 -0800 (PST)
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This series adds OMAP4 suspend and cpuidle support till MPU subsystem
> (MPUSS) off-mode. The suspend on SMP machines uses cpu-hotplug 
> infrastructure to take down the non-boot CPUs. We put secondary
> CPU(CPU1 in OMAP4) to OFF state via cpu-hotplug.
> In cpuidle too, low power states are attempted only when the
> CPU1 is put to OFF state via cpu-hotplug because of hardware
> constraints.

Minor nit on patch subjects:  both OMAP and PM are acronyms, please
capitalize.

Also, can you rebase this on Paul's integration-2.6.39 branch?  There
are several things in this series that conflict with changes there.

Thanks,

Kevin
