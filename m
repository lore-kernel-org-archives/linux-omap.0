From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: am3517: geting MMC working
Date: Fri, 20 Jul 2012 12:58:53 +0530
Message-ID: <CANrkHUasORhcujiUixhBLJ3_QuUEX3iR5mYn1LMqdk70sMWCsg@mail.gmail.com>
References: <5007A838.3040309@visionsystems.de>
	<CAMQu2gyGH2r1vqEx5DCiv8xr=Lp+p1_5nvrtQe9RdpnfecSoag@mail.gmail.com>
	<5007AF7C.1010902@visionsystems.de>
	<CAMQu2gx83tx66kQtF9v_v6yaw-L6v8QMc9u3bokX68ZhzC0tiA@mail.gmail.com>
	<5007B721.9070305@visionsystems.de>
	<CANfBPZ8tfApLcL2WGsP6jgwv7zafywJp7oHQ6E=xBYN8KYyeww@mail.gmail.com>
	<5007C215.7020904@visionsystems.de>
	<CANfBPZ9PcEWUUuFWBD3p9hk6FEEyUJh9cfM3hojayk+Wdycs5A@mail.gmail.com>
	<alpine.DEB.2.00.1207191532560.14390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:44816 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752517Ab2GTH24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 03:28:56 -0400
Received: by lban1 with SMTP id n1so4262377lba.38
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 00:28:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207191532560.14390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, yegor_sub1@visionsystems.de, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

On Fri, Jul 20, 2012 at 3:08 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 19 Jul 2012, S, Venkatraman wrote:
>
>> >From this, one can only infer that the card is not responding at all,
>> and all attempts
>> are returning with a timeout (CTO=Command Time Out).
>
> Looks to me like the card is responding to CMD8, CMD55, ACMD41, and CMD0.
> It's only CMD52 and CMD5 that are timing out.  Aren't those timeouts
> expected with a SD memory card?

yes, those timeouts are expected for SD card.
The failure is due to irq not received/missing for last CMD0.
Hi Yegor, Can you provide details for the SD card being used.

>
>
> - Paul
