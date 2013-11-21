From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Thu, 21 Nov 2013 09:16:40 +0100
Message-ID: <528DC168.7090204@linutronix.de>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com> <20131120220212.GA12776@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37688 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab3KUIQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 03:16:43 -0500
In-Reply-To: <20131120220212.GA12776@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roger Quadros <rogerq@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>

On 11/20/2013 11:02 PM, Ezequiel Garcia wrote:
> (Forgot to Cc OMAP people)

Felipe posted a redo of this area to fix this problem a while back. See
  http://www.spinics.net/lists/linux-usb/msg97286.html

Sebastian
