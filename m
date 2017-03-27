From: Moreno Bartalucci <moreno.bartalucci@tecnorama.it>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Mon, 27 Mar 2017 18:20:29 +0200
Message-ID: <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
 <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908> <20170327143049.GG10760@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327143049.GG10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Bin Liu <b-liu@ti.com>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org


> Il giorno 27 mar 2017, alle ore 16:30, Tony Lindgren <tony@atomide.com> ha scritto:
> 
> […]
> I wonder if the following test patch allows the mode changing
> devices to been properly found? Of course it's just for testing,
> and scanning for devices takes now 5 seconds.. But it might
> provide clues why musb thinks no devices are connected and we
> cut VBUS.
> 
> […]

Hi Tony,

thanks for your patch.

I tested it with both current mainline kernel and my “production” kernel (4.9.13): they have the same behaviour.

During boot, vbus is first asserted, then removed for a slightly longer time than before (most likely 5 seconds now), then reasserted.

When my device is mode-switched, it is working properly with your patch.

If I understood your patch, however, if the device (anyone, not just my one) takes longer to switch, VBUS is deasserted anyway.

Although this patch is working for me, personally I would prefer a solution which would not deassert VBUS. At least on a host only port. Honestly I don’t know how a dual role port should work.

Regards,

Moreno
