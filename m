From: Paul Walmsley <paul@pwsan.com>
Subject: Re: am3517: geting MMC working
Date: Thu, 19 Jul 2012 15:38:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207191532560.14390@utopia.booyaka.com>
References: <5007A838.3040309@visionsystems.de> <CAMQu2gyGH2r1vqEx5DCiv8xr=Lp+p1_5nvrtQe9RdpnfecSoag@mail.gmail.com> <5007AF7C.1010902@visionsystems.de> <CAMQu2gx83tx66kQtF9v_v6yaw-L6v8QMc9u3bokX68ZhzC0tiA@mail.gmail.com> <5007B721.9070305@visionsystems.de>
 <CANfBPZ8tfApLcL2WGsP6jgwv7zafywJp7oHQ6E=xBYN8KYyeww@mail.gmail.com> <5007C215.7020904@visionsystems.de> <CANfBPZ9PcEWUUuFWBD3p9hk6FEEyUJh9cfM3hojayk+Wdycs5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33028 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2GSVis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 17:38:48 -0400
In-Reply-To: <CANfBPZ9PcEWUUuFWBD3p9hk6FEEyUJh9cfM3hojayk+Wdycs5A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: yegor_sub1@visionsystems.de, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>

On Thu, 19 Jul 2012, S, Venkatraman wrote:

> >From this, one can only infer that the card is not responding at all,
> and all attempts
> are returning with a timeout (CTO=Command Time Out).

Looks to me like the card is responding to CMD8, CMD55, ACMD41, and CMD0.  
It's only CMD52 and CMD5 that are timing out.  Aren't those timeouts 
expected with a SD memory card?


- Paul
