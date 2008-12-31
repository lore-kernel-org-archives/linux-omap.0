From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH 5/5] omap mmc: Add new omap hsmmc controller for 2430
 and 34xx
Date: Wed, 31 Dec 2008 18:59:28 +0100
Message-ID: <20081231185928.2ba325e6@mjolnir.drzeus.cx>
References: <20081207213617.10456.43951.stgit@localhost>
	<20081207215139.10456.46405.stgit@localhost>
	<20081221171700.3efc0c3a@mjolnir.drzeus.cx>
	<20081229165531.GG22065@atomide.com>
	<20081230083624.GD7850@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:47762 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752598AbYLaR7c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Dec 2008 12:59:32 -0500
In-Reply-To: <20081230083624.GD7850@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>, David Brownell <david-b@pacbell.net>

On Tue, 30 Dec 2008 10:36:26 +0200
Tony Lindgren <tony@atomide.com> wrote:

> 
> Here's one more version that leaves out the unnecessary TWL4030
> dependency in the Kconfig as pointed out by David Brownell.
> 

Looks ok.

Acked-by: Pierre Ossman <drzeus@drzeus.cx>

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
