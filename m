From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Fri, 6 Dec 2013 13:52:31 -0600
Message-ID: <1386359551.7375.141.camel@snotra.buserror.net>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	 <CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	 <20131202115422.1f8c73f6@skate>
	 <CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
	 <20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
	 <20131202160219.40286dc9@skate>
	 <20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com>
	 <CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com>
	 <20131202165103.726314d9@skate>	<529CAEA3.2080808@ti.com>
	 <20131202170606.2191fd89@skate>
	 <20980858CB6D3A4BAE95CA194937D5E73EA50A23@DBDE04.ent.ti.com>
	 <20131202171907.56c9300a@skate>
	 <20980858CB6D3A4BAE95CA194937D5E73EA50AA4@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:13880
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208Ab3LFTwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 14:52:46 -0500
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA50AA4@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Javier Martinez Canillas (javier@dowhile0.org)" <javier@dowhile0.org>, "Rini, Tom" <trini@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Mon, 2013-12-02 at 17:05 +0000, Gupta, Pekon wrote:
> (2) Also selection of ecc-scheme mainly depends on NAND device parameter
>      (like density, page-size, oobsize) which remain constant for a device
>     (all NAND partitions). Thus all partitions should use *same* ecc-scheme
>     preferable highest possible available with NAND device & kernel.

It was pointed out earlier in the thread that there are chips for which
it is not constant throughout the device (i.e. the boot block is
special, presumably implemented differently in hardware).

> (3) Kernel uses same driver instance to handle all MTD partitions, so if one
>    partition uses HAM1 while other uses BCH8, and both are simultaneously
>    mounted, then it would be difficult for driver to switch ecc-schemes while
>   doing interleaved Read/Write between the partitions.
>   (though it can be added in framework, but then it's too much over-head).

Don't think of it as switching back and forth for every access, but
rather having dynamic dispatch to the proper code for any given access.

I'm not sure that partitions are the right place to implement this, as
they're a higher level abstraction.  If the NAND chip says that 1-bit
correction is good enough for certain blocks but not others, then that's
chip-level information that the driver ought to know about independently
of partitioning.  OTOH, that doesn't provide the ability to manage
compatibility with entities that use stronger correction than is needed
(or different ways of achieving the same level of correction), but it
could be a simpler way to solve the basic problem of boot blocks being
special.

-Scott



