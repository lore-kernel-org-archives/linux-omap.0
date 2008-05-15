From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: ALSA SoC for TWL4030
Date: Thu, 15 May 2008 17:39:32 +0200
Message-ID: <8AF7AD1D-C577-4C88-9F87-05F742FE2895@student.utwente.nl>
References: <5e088bd90805150818h1c2a5d8ep263811c8baed333a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:5288 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755914AbYEOPkC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2008 11:40:02 -0400
In-Reply-To: <5e088bd90805150818h1c2a5d8ep263811c8baed333a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 15 mei 2008, om 17:18 heeft Steve Sakoman het volgende geschreven:
> I'm thinking of tackling audio support for the OMAP3 EVM next.
>
> I'd like to make sure that I'm not duplicating work :-)
>
> Is anyone aware of any existing efforts to support the TWL4030 audio
> functionality?  I've seen the TI work in the 2.6.22 kernel, but it is
> not an SoC driver and seems to use a different mcbsp implementation
> than is in the current linux-omap tree.

There does seem to be an ASoC driver for the McBSP2 I2S side, but the  
KConfig entry:

- --

config SND_OMAP_SOC_MCBSP
         tristate
         select OMAP_MCBSP

- --

doesn't show up in menuconfig :(

Anyway, it is rumoured that the tlv320aic3x is similar to the twl, so  
you could have a look at tlv320aic3x.c.


regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFILFk2MkyGM64RGpERAiHOAKC3l3F8FHdsLixiUmdBDEB/otzMswCfU4RU
p6t5EnoaxxNEkJCttkiQwTw=
=eBCX
-----END PGP SIGNATURE-----
