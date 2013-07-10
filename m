From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: USB & hwmon on am33xx
Date: Wed, 10 Jul 2013 11:37:26 +0530
Message-ID: <51DCFA1E.3000202@ti.com>
References: <51DC3B39.6000104@linutronix.de> <51DC5185.4000804@ti.com> <51DC6C00.7090402@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51732 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab3GJGHh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jul 2013 02:07:37 -0400
In-Reply-To: <51DC6C00.7090402@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 7/10/2013 1:31 AM, Sebastian Andrzej Siewior wrote:
> On 07/09/2013 08:08 PM, Mugunthan V N wrote:
>> Yes, you need hwmod entry for each of the above device. Since USB has only only
>> clock ctrl register, have one as parrent and make other  devices as child node.
>> you can take CPSW as an example.
> So there is not some kind of ref counting if I use this entry twice?
> What about the PWM as an example? It has two child nodes and also only
> one clock register.
>
Yes, you can take PWM as example.

Regards
Mugunthan V N
