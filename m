From: Afzal Mohammed <afzal@ti.com>
Subject: Re: AM335x, early printk
Date: Tue, 20 Aug 2013 11:26:30 +0530
Message-ID: <5213050E.1090302@ti.com>
References: <5211FFA3.6060407@linutronix.de> <CAORVsuWy3D1WcCMbr0UB-kp+DOMMro30xicd-Mxf34MYyVGpdg@mail.gmail.com> <52121176.2050401@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38098 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab3HTF4l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Aug 2013 01:56:41 -0400
In-Reply-To: <52121176.2050401@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sebastian,

On Monday 19 August 2013 06:07 PM, Sebastian Andrzej Siewior wrote:

> Yes. I do not see the decompress messages but I have an early console
> later on. Unfortunately it stops now right at the serial core:
> 
> |pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
> |Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled

I vaguely remember facing a similar issue on it's yet to be born sibling
while trying to woke it up in the womb, see if placing dtb at a
different location helps (probably so that images won't get corrupted)

Regards
Afzal
