From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using Dual-mode Timers
Date: Tue, 16 Nov 2010 09:01:44 -0800
Message-ID: <874obhi4nb.fsf@deeprootsystems.com>
References: <1289762929-7682-1-git-send-email-marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41311 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab0KPRBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 12:01:48 -0500
Received: by qwh6 with SMTP id 6so723061qwh.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 09:01:48 -0800 (PST)
In-Reply-To: <1289762929-7682-1-git-send-email-marathon96@gmail.com> (Grant
	Erickson's message of "Sun, 14 Nov 2010 11:28:49 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Grant Erickson <marathon96@gmail.com> writes:

> This patch adds support to request and use one or more of the OMAP
> dual-mode timers as a generic PWM device compatible with other generic
> PWM drivers such as the PWM backlight or PWM beeper driver.

How will this co-exist with the PWM on the twl6030 PMIC
(drivers/mfd/twl6030-pwm.c.)    Both are exporting the same API.

Regarding multilpe PWM drivers, there has been discussion on the
linux-embedded list[1] regarding a more generic PWM framework, and a few
other projects working on PWM for OMAP[2].  Someone needs to step up and
consolidate/push this work forward as there is a clear need for a more
generic PWM infrastructure on various SoCs.  Your work is another
example of similar work that needs to be coordinated with the other projects.

> Boards can register such devices using platform data such as in the following
> example:
>
> 	static struct omap2_pwm_platform_config pwm_config = {
> 	    .timer_id           = 10,   // GPT10_PWM_EVT
> 	    .polarity           = 1     // Active-high
> 	};

Board code should not have to know which timers are PWM capable.  This
information is fixed at the SoC level.  

This information is available and is part of the in-progress conversion
of the timers to use the omap_hwmod infrastructure.  There are subsets
of the timers that have various features (1ms timers, PWM capable, etc.)
Using hwmod classes, they can be grouped together such that board code
does not have to know which timers on which SoC are PWM capable.   It
can simply request a timer with certain capabilities.

Kevin

[1] http://marc.info/?l=linux-embedded&m=128594628918269&w=2
[2] http://marc.info/?l=linux-embedded&m=128599642406671&w=2


