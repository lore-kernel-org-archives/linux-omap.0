From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: AM335x, early printk
Date: Mon, 19 Aug 2013 14:37:10 +0200
Message-ID: <52121176.2050401@linutronix.de>
References: <5211FFA3.6060407@linutronix.de> <CAORVsuWy3D1WcCMbr0UB-kp+DOMMro30xicd-Mxf34MYyVGpdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48517 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab3HSMhM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Aug 2013 08:37:12 -0400
In-Reply-To: <CAORVsuWy3D1WcCMbr0UB-kp+DOMMro30xicd-Mxf34MYyVGpdg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 08/19/2013 02:27 PM, Jean Pihet wrote:
> Hi!

Hi Jean,

> You need to add 'earlyprintk' in the kernel command line, given (I
> suppose) by U-Boot.

Ah, good hint.

> 
> I hope this helps!

Yes. I do not see the decompress messages but I have an early console
later on. Unfortunately it stops now right at the serial core:

|pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
|Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled

> 
> Jean

Sebastian
