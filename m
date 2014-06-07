From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH] dts: Add UARTs to am335x-bone-common.dtsi
Date: Sat, 7 Jun 2014 20:19:26 +0400 (MSK)
Message-ID: <alpine.LRH.2.00.1406072017510.15288@lnfm1.sai.msu.ru>
References: <alpine.LRH.2.00.1406071845220.13290@lnfm1.sai.msu.ru> <CAOCHtYjFT_96wxbsAUY4-aKAC7LmqVpFEGDfyLTODFQ-uy9e+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOCHtYjFT_96wxbsAUY4-aKAC7LmqVpFEGDfyLTODFQ-uy9e+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


On Sat, 7 Jun 2014, Robert Nelson wrote:
> These need to stay disabled in mainline, so drop the status = "okay";
> , (till we get a working capemgr/overlay). Otherwise the pinmuxing
> looks good.

What chances that we will eventually have working overlay in the mainline?
