From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: am3517: geting MMC working
Date: Thu, 19 Jul 2012 15:38:03 +0530
Message-ID: <CANrkHUZcev9=ef2GNM=7vEr7=Ym2gTL82sE7CgG8ApH92Fr=Sw@mail.gmail.com>
References: <5007A838.3040309@visionsystems.de>
	<CAMQu2gyGH2r1vqEx5DCiv8xr=Lp+p1_5nvrtQe9RdpnfecSoag@mail.gmail.com>
	<5007AF7C.1010902@visionsystems.de>
	<CAMQu2gx83tx66kQtF9v_v6yaw-L6v8QMc9u3bokX68ZhzC0tiA@mail.gmail.com>
	<5007B721.9070305@visionsystems.de>
	<CANfBPZ8tfApLcL2WGsP6jgwv7zafywJp7oHQ6E=xBYN8KYyeww@mail.gmail.com>
	<5007C215.7020904@visionsystems.de>
	<CANfBPZ9PcEWUUuFWBD3p9hk6FEEyUJh9cfM3hojayk+Wdycs5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:60291 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752258Ab2GSKIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 06:08:05 -0400
Received: by lbbgj10 with SMTP id gj10so4217501lbb.23
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 03:08:03 -0700 (PDT)
In-Reply-To: <CANfBPZ9PcEWUUuFWBD3p9hk6FEEyUJh9cfM3hojayk+Wdycs5A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, yegor_sub1@visionsystems.de
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

On Thu, Jul 19, 2012 at 2:27 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> On Thu, Jul 19, 2012 at 1:45 PM, Yegor Yefremov
> <yegor_sub1@visionsystems.de> wrote:

>> Waiting for root device /dev/mmcblk0p2...
>> mmc0: starting CMD0 arg 00000000 flags 000000c0
>> omap_hsmmc omap_hsmmc.0: mmc0: CMD0, argument 0x00000000
>>
>
> From this, one can only infer that the card is not responding at all,
> and all attempts
> are returning with a timeout (CTO=Command Time Out).
> These (control) commands don't use DMA, so it's not a DMA issue upto this.
> If the card is fine, and it worked before, I would suggest a bisect.
> Meanwhile I'll check lo-master with my OMAP4 boards.
>
> ~Venkat

I checked on 4430sdp, OMAP4 is able to detect both eMMC and SD with lo-master.

-- 
Thanks and Regards,
Balaji T K
