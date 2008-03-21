From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP5910 I2C problem
Date: Fri, 21 Mar 2008 12:58:39 -0500
Message-ID: <5573C19A4BBDB441BED2A44157E970530376B225@dlee12.ent.ti.com>
References: <cb3afdb90803131117s3974e622n6a4f07d3ced132b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47530 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757245AbYCUR6s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Mar 2008 13:58:48 -0400
Content-class: urn:content-classes:message
In-Reply-To: <cb3afdb90803131117s3974e622n6a4f07d3ced132b7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Kechin <okechin.omap@gmail.com>, linux-omap@vger.kernel.org

>  I've experienced problem with OMAP5910 I2C driver in my custom board.
>  It freezes after some working time.
>  When it freezes, register I2C_STAT show that XUDF (or ROVR) bit is
set
>  and SCL pin
>  is in low state.
>  I2C_CNT register is not zero too, but buf_len counter is zero.
>  Attempt to use init() function do not help in this situation.
>  Only things I can do with it - set I2C to debug mode and make some
SCL
>  clocks by hand.
>  After this I2C state machine can work for some time.
>  When I2C clock is set to 100kHz it happens almost in every transfer -
I
>  try to read/write
>  EEPROM. In 20kHz it still can happen too (on heavy load much
frequently).
>  It's look like internal I2C state machine is broken.
>  So, for now I replace i2c algorithm with i2c_algo_bit and everything
>  works fine.
> 
>  I'm curious - only I have such a problem with I2C bus in OMAP 5910 or
>  someone else too?
>  May be there is better solution?


I cannot say specifically, but I would recommend that you check out the
OMAP5910 device errata document and see if any of the known silicon
defects regarding the i2c peripheral could be impacting you. 

You can find the device errata here: 
http://focus.ti.com/docs/prod/folders/print/omap5910.html

Cheers
Jon 
