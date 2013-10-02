From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 4/5] dma: cppi41: only allocate descriptor memory once
Date: Wed, 02 Oct 2013 09:13:27 +0200
Message-ID: <524BC797.3080702@linutronix.de>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com> <1379861404-8250-5-git-send-email-zonque@gmail.com> <20130926082604.GA24205@linutronix.de> <524AC987.5000301@gmail.com> <524AF6AF.50704@linutronix.de> <524AFF08.7080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40586 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3JBHNb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 03:13:31 -0400
In-Reply-To: <524AFF08.7080206@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, sergei.shtylyov@cogentembedded.com, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

On 10/01/2013 06:57 PM, Daniel Mack wrote:
> That sound's like a good idea. Everything that make the driver smaller
> and easier to understand is certainly a good thing :)
> 
> So we can drop this patch favor of your cleanup. However, I appreciate
> if you did it on top of the second round of patches I sent today please,
> because my resume() implementation uses DESCS_AREAS as well.

Okay, no problem. Let me look at those and once they are merged I do
the cleanup.

> 
> 
> Thanks,
> Daniel

Sebastian
