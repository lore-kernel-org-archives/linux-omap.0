From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: ehci problem on OMAP35xx
Date: Thu, 16 Apr 2009 20:29:45 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EAA6AC81@dbde02.ent.ti.com>
References: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739404280467EF@dbde02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702EAA6AC27@dbde02.ent.ti.com>
 <dbdb2ea60904160753r6da23b3fw18d90d2f4e4a7b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59908 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756236AbZDPO77 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 10:59:59 -0400
In-Reply-To: <dbdb2ea60904160753r6da23b3fw18d90d2f4e4a7b9@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: twebb [mailto:taliaferro62@gmail.com]
>Sent: Thursday, April 16, 2009 9:53 AM
>To: Pandita, Vikram
>Cc: Gupta, Ajay Kumar; linux-omap@vger.kernel.org Mailing List
>Subject: Re: ehci problem on OMAP35xx
>
>Yes.  It's not described in the datasheet but SMSC has confirmed the
>part will work in the mode where the clock is driven from OMAP to
>xcvr.

the first thing that has to successfully happen over ULPI is the ULPI reset.
OMAP will issue a RESET over ULPI as a TX CMD of 0x84 0x69.
When this reset command is sent over ULPI, PHY state m/c should have locked on to the 60mhz clock.

That's the kind of hack you are seeing in ehci-omap.c file today, though Not the right place to put the hack considering it's a generic driver.


>
>Other suggestions?  One thing we're now seeing is very inconsistent
>readback of transceiver registers when accessed via INSNREG05_ULPI.
>Even readback of RO registers (like Vendor ID High) doesn't work
>consistently.
>
>twebb

