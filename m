From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] ARM: OMAP2+: Avoid idling memory controllers with
 no drivers
Date: Mon, 22 Jul 2013 17:48:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307221746430.10891@utopia.booyaka.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com> <1374487277-26099-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47549 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458Ab3GVRso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 13:48:44 -0400
In-Reply-To: <1374487277-26099-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, mpfj-list@newflow.co.uk, vaibhav.bedia@ti.com, khilman@linaro.org, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, grygorii.strashko@ti.com

Hi

On Mon, 22 Jul 2013, Rajendra Nayak wrote:

> Memory controllers in OMAP (like GPMC and EMIF) have the hwmods marked with
> HWMOD_INIT_NO_IDLE and are left in enabled state post initial setup.
> 
> Even if they have drivers missing, avoid idling them as part of
> omap_device_late_idle()

Since this patch is intended for the -rc series, it's best if you explain 
here what effects this patch will fix.  i.e., does this fix a crash, a 
warning, etc?  Also maybe update your series description message?


- Paul
