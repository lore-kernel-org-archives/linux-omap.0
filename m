From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [pacth] I2C bug fixes for L-O and L-Z
Date: Mon, 16 Feb 2009 08:19:05 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55842 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbZBPOTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 09:19:14 -0500
In-Reply-To: <1234767724.16827.7.camel@eenurkka-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> Could you please also address the question of the load on the SCL line?

Are you talking about rise/fall time?

I can comment on bits I picked up reading and talking to others.

The current data sheets I looked at give a couple kinds of guidance for resistor usage. One type has you measure bus capacitance then gives optimized resistor values per speed range in a capacitance range. The other type gives rise/fall which you should measure on board then choose the correct value for your board.

You need to have a low enough value resistor such that it pulls voltage quickly enough. One tradeoff is the lower the value the more current flows per bit.

> In my understanding, many boards are using the experimental values
> from TRM for SCLL, SCLH, HSSCLL and HSSCLH. I have notices that those
> "default" values fail to provide a standard I2C clock for, at least,
> boards that I have tested. Should those values be board specific and
> taken off from the I2C driver? Or should a note be added there saying
> "These values are board specific and they depend on the load on the SCL
> line. Please measure and validate correct values for your board".

So yes, how fast your I2C bus can safely run is board dependent.  However, depending on resistor choice you might have full range.

The way the resistor/capacitive ranges are defined if you're good for HS I guess you should be good for fast and standard speed.

You should be engaging your board people if what you are measuring is not to your needs. If the board has only put in a FS value then HS operation might be limited.  In that case you might need tables as you say in question.

* The idea I had when looking at this is you might be able to make use of the 3 internal pull-ups which exist on the path (and possible external pullup) to make sort of a resistive network.  This might allow you to lower resistance when running at high speeds and make it higher at slower ones (to save power).  This should expand speed range even if your board designer only put a FS resistor value in.

Does that help?

Regards,
Richard W.


