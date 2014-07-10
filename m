From: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>
Subject: Re: [PATCH 6/6] tty: serial: Add 8250-core based omap driver
Date: Thu, 10 Jul 2014 11:14:28 -0500
Message-ID: <CAGo_u6r57s6kpF81W-hq96PFizOp3m+XEh3bmzJOp0oPHYRNCg@mail.gmail.com>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
	<1404928177-26554-7-git-send-email-bigeasy@linutronix.de>
	<20140710070948.GH28884@atomide.com>
	<53BEB5AF.7010604@linutronix.de>
	<53BEB951.2040207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <53BEB951.2040207@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Carlos Hernandez <ceh@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 10, 2014 at 11:03 AM, Carlos Hernandez <ceh@ti.com> wrote:
> 1) Append no_console_suspend to bootargs
Not needed. ideally with pinctrl wakeup capability, this should work.
if you do no_console_suspend, the module is not powered down.
