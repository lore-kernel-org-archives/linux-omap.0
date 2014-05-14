From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: enable LEDS class support
Date: Wed, 14 May 2014 18:40:33 +0200
Message-ID: <CABxcv=nk67v9vdDAVExj3nDMRP8izitPXC+XWVvoAOKc=Rfjag@mail.gmail.com>
References: <1400067905-20786-1-git-send-email-javier@dowhile0.org>
	<20140514151004.GA18463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:40725 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbaENQkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 12:40:35 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so2221480wgg.24
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2014 09:40:33 -0700 (PDT)
In-Reply-To: <20140514151004.GA18463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Tony,

On Wed, May 14, 2014 at 5:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [140514 04:46]:
>> Commit 5610b8ede ("ARM: OMAP2+: AM33XX: omap2plus_defconfig:
>> Add support for few drivers") added support for different
>> drivers including GPIO based leds.
>>
>> But LEDS_GPIO config option depends on LEDS_CLASS which was
>> not included so GPIO leds option is not selected. Adding as
>> built-in option since the related options are built-in too.
>
> Yeah this is already enabled with the PM related patches as
> we can use the n900 debug LEDs to monitor for PM related
> regressions. So patch "ARM: dts: Enable N900 keyboard sleep
> leds by default" enables CONFIG_LEDS_CLASS, I've sent a pull
> request for that few days ago for v3.16.
>

Ok, I didn't notice before because I was using a custom defconfig
which had it enabled.

Sorry, I missed that series somehow, glad to know that it is already enabled.

> Regards,
>
> Tony
>

Best regards,
Javier
