From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: OMAP3 NAND ECC selection
Date: Mon, 9 Dec 2013 04:33:51 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA52ADF@DBDE04.ent.ti.com>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
	<CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
	<52A04E75.3010609@corscience.de>
	<alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
	<20131205171326.GA26766@atomide.com>
	<CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
	<20131205182628.GF2345@localhost>
	<20980858CB6D3A4BAE95CA194937D5E73EA5222E@DBDE04.ent.ti.com>
	<20131205200618.19b33ee2@skate>
	<CAN8TOE-cv5ppz0Q_asK=6WdRPaK9SAd1ccZF0Ax7QCdGOE7Fjw@mail.gmail.com>
 <20131205203237.047cfbb9@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56904 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614Ab3LIEed convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Dec 2013 23:34:33 -0500
In-Reply-To: <20131205203237.047cfbb9@skate>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Brian Norris <computersforpeace@gmail.com>, Mike Dunn <mikedunn@newsguy.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?iso-8859-1?Q?Andreas_Bie=DFmann?= <andreas.biessmann@corscience.de>, Peter Meerwald <pmeerw@pmeerw.net>

Hi,

>From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
>>On Thu, 5 Dec 2013 11:24:18 -0800, Brian Norris wrote:
[...]

>> Using 1-bit ECC on NAND is not a long-term solution. Given that fact,
>> I think your ROM code is what may need to change, not the entire MTD
>> subsystem.
>
>As someone (Tom Rini maybe?) pointed out, today the shift is 1-bit ECC
>supported by ROM code vs. 4 or 8 bits required by NAND. But we can very
>well imagine that tomorrow ROM code will support BCH4 (and the NAND
>will ensure block 0 is OK for use with BCH4) but the rest of the NAND
>will require BCH16 or something like that.
>
>I'm not designing ROM code, and the fact that they today have this
>limitation, should be an indication that Linux should be capable of
>handling different ECC schemes to handle those hardware constraints.
>
Just to highlight few more points:
(1) ROM code on newer OMAP platforms like AM33xx do have the ability
to select ECC scheme by reading a specific location from EEPROM
connected to I2C0. 
Reference:
	http://www.ti.com/product/am3359
	http://www.ti.com/litv/pdf/spruh73i 
	Chapter 26: Initialization  
	Section: 26.1.7.4  Memory Booting > NAND
  	Table 26-17. NAND Geometry Information on I2C EEPROM

(2) And going forward, ECC based NAND devices may be phased out,
and BE-NAND (Built-in) NAND devices are becoming popular. As both
cost and density wise they are same to SLC NANDs today.  Thus issue
of un-compatibility of ecc-scheme with ROM code, will not hold true.
We already have some BE-NAND support in our generic driver.
http://patchwork.ozlabs.org/patch/222186/

However, I also support user space tool approach rather than having
this included in NAND driver.


with regards, pekon
