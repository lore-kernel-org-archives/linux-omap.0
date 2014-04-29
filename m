From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Tue, 29 Apr 2014 10:06:03 +0200
Message-ID: <535F5D6B.6090802@linutronix.de>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar> <CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com> <535F5BA5.6000903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36397 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933062AbaD2IGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 04:06:06 -0400
In-Reply-To: <535F5BA5.6000903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 04/29/2014 09:58 AM, George Cherian wrote:
>>> This is easily fixed by moving the node at the beggining of the child
>>> list,
>>> so it's probed first.
> This will give issues on module removal.
> Since we use device_for_each_child in remove patch, it will try to
> remove cppi dma controller, while the channel
> is still in use by musb node.

Isn't this currently disabled because it blew up in the phy code?

Sebastian

