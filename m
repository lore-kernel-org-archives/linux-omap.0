From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Wed, 15 Jul 2009 18:03:00 -0500
Message-ID: <4A5E6024.4010605@ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFE@dlee06.ent.ti.com> <4A5D136D.8030701@ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7C3A@dlee06.ent.ti.com> <4A5E4D7A.6010706@ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7DB5@dlee06.ent.ti.com> <4A5E57C5.6000600@ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7DB9@dlee06.ent.ti.com> <4A5E58CA.3030206@ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7DBD@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34049 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756142AbZGOXDH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jul 2009 19:03:07 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202957C7DBD@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Sonasath, Moiz had written, on 07/15/2009 05:37 PM, the following:
 >
 > -----Original Message-----
 > From: Menon, Nishanth
 > Sent: Wednesday, July 15, 2009 5:32 PM

please stop top posting..

 >> Sonasath, Moiz had written, on 07/15/2009 05:29 PM, the following:
 >> I am also not sure, if the count=100; value will be enough time for 
the XUDF
 >>  > to be set. If not then it will keep running into timeout errors.
 >> Do you mean we need a delay for checking again? that should be easy to
 >> incorporate - what kind of delay are we speaking of here? do you 
have a
 >> count requirement for handling this? it is essentially the time b/w 
XRDY
 >> to XUNDF.. this should be deterministic rt?
 >>
 >
 > AFAIK, the time between XRDY/XDR and setting of XUDF bit is not
 >deterministic, it depends on the I2C bus speed but I am not sure if we
 >can translate the speed into a fixed count number which we can use as a
 > timeout limit. In that case we need to make a balanced assumption of
 >the count value so that we don't fall in the timeout case under normal
 >operation.
 >
 > May be someone can give a pointer here.
 >
Here is my attempt at this:
XRDY -> in this case the FIFO is completely empty - fill it up for XTRSH
XDR -> FIFO is not completely empty, fill as per TXSTAT reg.
if you look at the sequences of events that should happen ->
a) no previous data transmitted: XRDY, XUNDF
b) previous data available, XDR, XRDY, XUNDF
The variables are:
i) bus speed
ii) num bytes to empty (if XRDY then 0, else TXSTAT)

Time = (num_bytes+c) * (1/bus_speed)
where c = some constant time interval for XRDY->XUNDF.. I think..

One possible strategy:
a)Worst case is XTRSH, so, Compute time prior to entry into transmit
loop. Set the count as this+ add a constant for additional events
b) Add a constant delay when you decide to continue back - not sure if
cpu_relax is predictable delay..

--
Regards,
Nishanth Menon
