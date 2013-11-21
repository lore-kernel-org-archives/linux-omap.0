From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Thu, 21 Nov 2013 12:44:51 +0100
Message-ID: <528DF233.40502@linutronix.de>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com> <20131120220212.GA12776@localhost> <528DC168.7090204@linutronix.de> <20131121113025.GA2942@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38816 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab3KULoz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 06:44:55 -0500
In-Reply-To: <20131121113025.GA2942@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roger Quadros <rogerq@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>

On 11/21/2013 12:30 PM, Ezequiel Garcia wrote:
> Ah, good to know. That patch should be picked ASAP, without it the USB
> in AM335x is broken. Is it already too late to -rc1?
Yes.

> Who is supposed to merge that? Greg?

Felipe will start collecting fixes once -rc1 is out [0] so it should be
part of -rc2.

[0] This was his work flow for the last couple cycles, I assume he will
    continue.

Sebastian
