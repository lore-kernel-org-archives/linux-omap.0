From: Paul Walmsley <paul@pwsan.com>
Subject: RE: I2C broken on OMAP 2430SDP?
Date: Mon, 14 Dec 2009 13:38:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912141335580.12561@utopia.booyaka.com>
References: <alpine.DEB.2.00.0912010857070.13408@utopia.booyaka.com> <CD8CC2B65FEE304DA95744A5472698F2029E755F76@dlee06.ent.ti.com> <alpine.DEB.2.00.0912030559500.13408@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC35608702FAA0C54C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38816 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbZLNUio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 15:38:44 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C54C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Sonasath, Moiz" <m-sonasath@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Hi Vikram,


On Thu, 3 Dec 2009, Pandita, Vikram wrote:
>
> By any chance is this related to running i2c at slower clock speed? 
> commit 6b61a83b31744d143b0e7bc92f463d831319eabc
>     The maximum I2C speed depends on the system clock for GAIA:
>     2.2 MHz (sys-clk = 19.2 MHz)
>     2.4 MHz (sys-clk = 26 MHz)
>     2.9 MHz (sys-clk = 38.4 MHz)

Thanks for the suggestion.  Changing the I2C speed to 2.2MHz did not fix 
it, but changing it to 400KHz did cause the messages to go away.  Perhaps 
something is wrong in the high-speed code?


- Paul
