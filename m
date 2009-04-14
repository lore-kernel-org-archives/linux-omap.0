From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: 2.6.29 and SDP3430
Date: Tue, 14 Apr 2009 15:33:35 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037BD7E8BE@dlee02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
 <20090409100343.71d34c16.jarkko.nikula@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702EAA6A3DF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56523 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbZDNUds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 16:33:48 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702EAA6A3DF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Pandita, Vikram
> Sent: Tuesday, April 14, 2009 3:08 PM
> To: Menon, Nishanth; Woodruff, Richard; Jarkko Nikula
> Cc: linux-omap
> Subject: RE: 2.6.29 and SDP3430
> I am also seeing a hang at following bootup time:
>
> console [ttyS2] enabled
> <6>brd: module loaded
> brd: module loaded
> <6>loop: module loaded
> loop: module loaded
> <6>i2c /dev entries driver
> i2c /dev entries driver
> ...


I looked really briefly on image with emulator.

It was in a big loop which fairly often was going into I2C.  Normal timer interrupts were firing.  Just the boot was not progressing.  It seems fixing is just time and debug.

Regards,
Richard W.


