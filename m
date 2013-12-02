From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Mon, 02 Dec 2013 14:04:15 +0100
Message-ID: <529C854F.3010101@linutronix.de>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com>	<1385730118-26402-2-git-send-email-rogerq@ti.com> <CAOf5uwmEkzFd=e3j8m8=qdTCAMkk_-DPw0fTm=7Vzy0PbE2oDQ@mail.gmail.com> <529C55DF.3000808@ti.com> <529C76AF.10106@linutronix.de> <529C7922.5000601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529C7922.5000601@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Felipe Balbi <balbi@ti.com>, lee.jones@linaro.org, sameo@linux.intel.com, tomi.valkeinen@ti.com, Stefan Roese <sr@denx.de>, ljkenny.mailinglists@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>
List-Id: linux-omap@vger.kernel.org

On 12/02/2013 01:12 PM, Roger Quadros wrote:
> You are right. The musb hwmod data doesn't have the HWMOD_INIT_NO_RESET
> flag, so hwmod should reset it during boot.
> 
> Maybe I too should just remove HWMOD_INIT_NO_RESET flag from the USB Host
> hwmod data, then we don't need to change this driver at all.
> 
> Benoit, Tony any comments?

Almost two years ago in commit de231388 ("ARM: OMAP: USB: EHCI and OHCI
hwmod structures for OMAP3") the "don't reset flag" has been added by
Keshava.

It refers to "Errata Id:i660" why it is required. Once you figured what
why it has been added you could have an idea if it is okay to remove it
and if the reset you do here might lead to it (I dunno).

> 
> cheers,
> -roger

Sebastian
