From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/5] usb: musb: call musb_port_suspend from
 musb_bus_suspend
Date: Wed, 2 Oct 2013 12:49:10 +0200
Message-ID: <20131002104910.GD16680@linutronix.de>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
 <1380634797-29541-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42004 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab3JBKtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 06:49:11 -0400
Content-Disposition: inline
In-Reply-To: <1380634797-29541-3-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

* Daniel Mack | 2013-10-01 15:39:54 [+0200]:

>Make musb_port_suspend() externally available, and call it when to host
>goes into suspend. This allows the core to go into suspend while a
>device is connected.

Sorry for asking this stupid question but what is usally happening when
the host goes to suspend and a device is connected? I think it is
disconnected & re-enumerated and resume and this not what you want,
right?
What happens if the device is unplugged while the host is suspended and
not there on resume?

>Signed-off-by: Daniel Mack <zonque@gmail.com>

Sebastian
