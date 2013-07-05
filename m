From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: musb: dsps: make it work with two instances
Date: Fri,  5 Jul 2013 15:32:53 +0200
Message-ID: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45303 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab3GENdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 09:33:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, george.cherian@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, b-cousson@ti.com

This enables the two musb instances on am335x to work.
Could someone explain what
	ti,hwmods = "usb_otg_hs";
doing? I would want to have something like
| musb {
|	 /* glue /*
|	    {
|	    	musb child node
|            }
| }

and this twice. This would put the glue layer into the right position and
remove this nonsense and the += 0x400 chicken dance (look for
musb_core_offset).

Sebastian

