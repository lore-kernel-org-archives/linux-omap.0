From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/3] dma: cppi41: more suspend/resume patches
Date: Wed, 9 Oct 2013 08:41:24 +0200
Message-ID: <20131009064124.GA3529@linutronix.de>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46357 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab3JIGl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 02:41:27 -0400
Content-Disposition: inline
In-Reply-To: <1380634271-27588-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

* Daniel Mack | 2013-10-01 15:31:08 [+0200]:

>Patch #1 restores more registers on resume time.
>
>Patch #2 is a cosmetic cleanup that emerged while digging through the
>driver and gaining a basic idea of how it's implemented. Nothing fancy.

I'm fine with those two.

>
>Patch #3, however, gives me headaches. I can't fully explain what's
>going on, but I can tell for sure that if fixes a problem that I stared
>on for many hours.

I'm still trying to verify if it breaks something or not. So I haven't
forgotten about this.

Sebastian
