From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 0/2] OMAP3: Display Support
Date: Fri, 12 Nov 2010 15:38:29 +0200
Message-ID: <1289569109.3297.280.camel@tubuntu>
References: <1288067315-30492-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:60335 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755502Ab0KLNii (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Nov 2010 08:38:38 -0500
In-Reply-To: <1288067315-30492-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Samreen <samreen@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>, Mukund Mittal <mmittal@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-10-26 at 06:28 +0200, ext Samreen wrote:
> This patch series adds the Display Support for OMAP3 platforms
> and the corresponding changes in the board files.
> 
> Version2:
>    - Optimised to configure INTBR from gpio to PWM1 mode setting and 
>    enabling of the PWM1 mode only when its not in PWM1 mode.

This patch set doesn't seem to apply to the latest kernel, conflicts in
arch/arm/mach-omap2/board-zoom-peripherals.c and
arch/arm/mach-omap2/include/mach/board-zoom.h. Can you rebase and
resend?

 Tomi


