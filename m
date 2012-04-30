From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family
 detection
Date: Mon, 30 Apr 2012 09:27:31 -0700
Message-ID: <20120430162731.GB18669@animalcreek.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
 <20120427220813.GE19196@animalcreek.com>
 <87aa1wyfq5.fsf@ti.com>
 <20120428202047.GA7068@numbers.woodsts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:54798 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2D3Q1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 12:27:32 -0400
Content-Disposition: inline
In-Reply-To: <20120428202047.GA7068@numbers.woodsts.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Derald D. Woods" <woods.rt@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Sat, Apr 28, 2012 at 03:20:48PM -0500, Derald D. Woods wrote:

>  Is there a kernel config
> that is commonly used by those testing the AM3517? or modified
> omap2plus? I think some issues that I am seeing involve wrong
> configuration assumptions by me.

I'm using omap2plus_defconfig with CONFIG_TI_DAVINCI_EMAC enabled
on an am3517evm board.

Does adding 'nohlt' to your cmdline help?

Mark
