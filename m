From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: FW: [PATCH 00/05] 34XX cpu idle patches - core off
Date: Mon, 30 Jun 2008 08:25:58 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BB6ED83@dlee02.ent.ti.com>
References: <008101c8d091$27d64bd0$68bf18ac@ent.ti.com>
	 <20080619114823.GB4953@codecarver.research.nokia.com>
	 <001d01c8d203$5cac7500$68bf18ac@ent.ti.com>
	 <20080619120507.GC4953@codecarver.research.nokia.com>
	 <001e01c8d205$a89ed4b0$68bf18ac@ent.ti.com>
	 <20080623144018.GC4468@codecarver.research.nokia.com>
	 <008201c8d84d$0577d540$68bf18ac@ent.ti.com>
	 <20080630104345.GC4379@codecarver.research.nokia.com>
	 <13B9B4C6EF24D648824FF11BE8967162035BB6ED25@dlee02.ent.ti.com>
 <1214829812.5081.9.camel@mort>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:56704 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760297AbYF3N0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 09:26:12 -0400
In-Reply-To: <1214829812.5081.9.camel@mort>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Sawant, Anand" <sawant@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> On Mon, 2008-06-30 at 07:45 -0500, ext Woodruff, Richard wrote:
>
> > For things like bluetooth or other the protocol should re-transmit.
>
> That's avoided with an out of band irq.

That can work assuming that external device gives you a 'pre' interrupt before it generates the real timing dependent one.  Some external device knowledgeable timer or buffering of the real event needs to happen.

Do some of your peripherals or some fpga glue do this?

In the past I've seen some OR'ing (with possibly conditioning) of interrupts back to a wake up capable gpio.  But even in these cases depending on the peripheral you need a little per-time for low idles. Utilizing low control where it exists seems like a natural pre-event.

Regards,
Richard W.
