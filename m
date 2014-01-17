From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 06/18] ARM: dts: omap3-overo: Enable MMC2
Date: Fri, 17 Jan 2014 14:22:27 +0100
Message-ID: <52D92E93.8050804@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>	<1389286092-27087-7-git-send-email-florian.vaussard@epfl.ch> <CABxcv=nO1ZtC7wjVSq+Qw9AmFGahpDUSjOZOO1+tYHhqo9P0Pw@mail.gmail.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:57609 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbaAQNWc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jan 2014 08:22:32 -0500
In-Reply-To: <CABxcv=nO1ZtC7wjVSq+Qw9AmFGahpDUSjOZOO1+tYHhqo9P0Pw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Javier

On 01/09/2014 09:43 PM, Javier Martinez Canillas wrote:
> [adding Enric Balletbo to cc]
> 
> Hello Florian,
> 
> On Thu, Jan 9, 2014 at 1:48 PM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
>> MMC2 is used by the on-board WiFi module populated on some boards
>> (based on Marvell Libertas 8688 SDIO).
>>
>> Note: currently WiFi only works on cold boot, as the module is not
>> properly reset (missing binding for the GPIO reset).
>>
> 
> Have you looked at commit 0e9fd777 ("ARM: dts: omap3-igep: Add support
> for LBEE1USJYC WiFi connected to SDIO") ?
> 
> If I remember correctly the LBEE1USJYC Wifi/BT combo module is
> basically a Marvell Libertas 8688 Wlan and Enric got soft reset
> working too by adding a GPIO property to the regulator for the reset
> GPIO.
> 
> Hope it helps,

Thank you, I got it working. It is a bit messy, as I have 3 GPIOs
(poweron, wifi-reset and bt-reset). As a regulator can control only one
GPIO, I had to define 3 regulators, and assigning them to the vmmc,
vqmmc, and vmmc_aux. I hope that a better solution will pop-up in this
thread [1]. It is a pity that the previous version of the GPIO-reset
controller was not merged.

Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/294907
