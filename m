From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL]: omap-serial updates for 3.4-rc
Date: Tue, 17 Apr 2012 10:35:31 -0700
Message-ID: <20120417173530.GC21106@atomide.com>
References: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
 <CAMrsUdKDhuDLr2=0uiQtY=r4pvmJQo=pJgERRCXySLghO7yGXA@mail.gmail.com>
 <CAMrsUdJ7wzX+Hnx_wBWNnCQz__0sMw8ruFGVWH+x3NGWG0NVQw@mail.gmail.com>
 <CAMrsUdJ9ehjC4-hChddQRnH0BtpFG3bVBTnm6zFZpU6F0za_bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39382 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2DQRfe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 13:35:34 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUdJ9ehjC4-hChddQRnH0BtpFG3bVBTnm6zFZpU6F0za_bg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi,

* Raja, Govindraj <govindraj.raja@ti.com> [120416 03:44]:
> 
> The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:
> 
>   Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-3-x/omap-serial.git for_3.4/uart_fixes
> 
> for you to fetch changes up to 381772fefe13e73fc3d01c462d401785767c3775:
> 
>   ARM: OMAP: serial: Fix the ocp smart idlemode handling bug
> (2012-04-16 15:46:26 +0530)
> 
> ----------------------------------------------------------------
> Govindraj.R (5):
>       OMAP2+: UART: Remove cpu checks for populating errata flags

Not a fix.

>       OMAP2+: UART: enable tx wakeup bit for wer reg

Not a fix, and should get reviewed and merged via linux-serial mailing
list.

>       OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx

Not a fix.

>       OMAP2+: UART: Fix incorrect population of default uart pads

I'll apply this directly with updated comments into fixes.

>       OMAP2+: UART: Add mechanism to probe uart pins and configure rx wakeup

Not ready and too intrusive for -rc cycle.
 
> Santosh Shilimkar (1):
>       ARM: OMAP: serial: Fix the ocp smart idlemode handling bug

It seems this can wait as the wake-up events are anyways broken right
now when we remove the muxing.

So not pulling.

Tony
