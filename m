From: Catalin Crenguta <catalin.crenguta@gmail.com>
Subject: Re: [PATCH v4 0/6] Touchscreen performance related fixes
Date: Fri, 12 Dec 2014 15:55:04 +0200
Message-ID: <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
	<20141124115116.GA14997@linutronix.de>
	<547C3A95.30605@ti.com>
	<547C3C19.5090501@linutronix.de>
	<547C42FF.5010700@ti.com>
	<CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
	<548A0125.6040708@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:62616 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968007AbaLLNzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2014 08:55:06 -0500
In-Reply-To: <548A0125.6040708@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nicolae Rosia <nicolae.rosia@gmail.com>, Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, richardcochran@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Brad Griffis <bgriffis@ti.com>, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jan Kardell <jan.kardell@telliq.com>, devicetree@vger.kernel.orgli

Hello,

I have tried your patches by cloning [1] and copying the
relevant files over the kernel I've cloned from [2].
It compiles & runs, but I'm seeing lots of pen-down/pen-up
events when I'm not touching the screen.
Any suggestions?

Hardware: Beaglebone Black with BB-View 4.3 Cape from Farnell

[1] git clone -b tsc-devel git://git.ti.com/kernel/tsc-adc.git
(tsc-devel branch)
[2] https://github.com/beagleboard/linux/tree/3.14
