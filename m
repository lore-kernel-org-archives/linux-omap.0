From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: USB & hwmon on am33xx
Date: Tue, 09 Jul 2013 22:01:04 +0200
Message-ID: <51DC6C00.7090402@linutronix.de>
References: <51DC3B39.6000104@linutronix.de> <51DC5185.4000804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58951 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3GIUBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 16:01:08 -0400
In-Reply-To: <51DC5185.4000804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 07/09/2013 08:08 PM, Mugunthan V N wrote:
> Yes, you need hwmod entry for each of the above device. Since USB has only only
> clock ctrl register, have one as parrent and make other  devices as child node.
> you can take CPSW as an example.

So there is not some kind of ref counting if I use this entry twice?
What about the PWM as an example? It has two child nodes and also only
one clock register.

> Regards
> Mugunthan V N

Sebastian
