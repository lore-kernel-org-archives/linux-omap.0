From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Wed, 11 Aug 2010 08:39:46 +0300
Message-ID: <20100811083946.494aac87.jhnikula@gmail.com>
References: <1281484431-17620-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43117 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab0HKFj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 01:39:58 -0400
Received: by ewy23 with SMTP id 23so4227133ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 22:39:56 -0700 (PDT)
In-Reply-To: <1281484431-17620-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

On Tue, 10 Aug 2010 16:53:51 -0700
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> From: Kevin Hilman <khilman@ti.com>
> 
> During idle, if the PER powerdomain transitions and CORE does not (as
> is the case with the lower C-states when using CPUidle) the IO pad
> wakeups are not being disabled in the idle path after they are
> enabled.
> 
> This patch ensures that the check for disabling IO wakeups also checks
> for PER transitions, matching the check done to enable IO wakeups.
> 
> Found when debugging PM/CPUidle related problems reported by Ameya
> Palande <ameya.palande@nokia.com>.  Problems were triggered
> particularily on boards with UART2 consoles (n900, Overo) since UART2
> is in the PER powerdomain.
> 
> Tested on l-o master (omap3_defonfig + CONFIG_CPU_IDLE=y) as well
> as with current PM branch.  Boards tested: n900, Overo, omap3evm.
> 
> Cc: Ameya Palande <ameya.palande@nokia.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---

I don't see the problem on N900 anymore after applying this patch. Feel
free to add:

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
