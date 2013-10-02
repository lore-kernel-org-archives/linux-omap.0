From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/5] usb: musb: move port reset to worker
Date: Wed, 2 Oct 2013 12:46:12 +0200
Message-ID: <20131002104612.GC16680@linutronix.de>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
 <1380634797-29541-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41962 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab3JBKqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 06:46:13 -0400
Content-Disposition: inline
In-Reply-To: <1380634797-29541-2-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

* Daniel Mack | 2013-10-01 15:39:53 [+0200]:

>musb_port_reset() sleeps, so we can't call it from atomic context. It
>is, however, called from places inside musb_hub_control() while
>&musb->lock is held, which leads to a "scheduling while atomic" warning.

I guess you are hit by the msleep(1) here.

>Fix this by moving the logic into a worker, and call it where the
>function was previously called directly.

I *think* the better approach here would be to replace the msleep(1) by
a busy loop. The thing is that you do now want to continue the operation
and having the reset in progress. It should complete _right_ _now_ i.e.
SET_PORT_FEATURE RESET is completed before the the next SET/GET request
arrives and with a workqueue you can not guarantee this.

>Signed-off-by: Daniel Mack <zonque@gmail.com>

Sebastian
