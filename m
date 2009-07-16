From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Thu, 16 Jul 2009 10:52:58 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202957C7EF0@dlee06.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFE@dlee06.ent.ti.com>
 <4A5D136D.8030701@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7C3A@dlee06.ent.ti.com>
 <4A5E4D7A.6010706@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7DB5@dlee06.ent.ti.com>
 <4A5E57C5.6000600@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7DB9@dlee06.ent.ti.com>
 <4A5E58CA.3030206@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7DBD@dlee06.ent.ti.com>
 <4A5E6024.4010605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41072 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbZGPPxJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 11:53:09 -0400
In-Reply-To: <4A5E6024.4010605@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hello Nishant,

Comments inlined,

Regards
Moiz Sonasath


-----Original Message-----
From: Menon, Nishanth 
Sent: Wednesday, July 15, 2009 6:03 PM
To: Sonasath, Moiz
Cc: linux-omap@vger.kernel.org; Kamat, Nishant; Paul Walmsley; Pandita, Vikram
Subject: Re: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153

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


[Moiz]

Let me just rephrase what you said and from what I see in the TRM,

XRDY-> when TX FIFO level is equal/below XTRSH and TXSTAT is equal/greater than XTRSH, LH will write number of data bytes specified by XTRSH
XDR-> when TX FIFO level is equal/below the XTRSH and TXSTAT is less than XTRSH, LH will write number of data bytes specified by TXSTAT
XUDF-> when shift register and the TX FIFO are empty and there are still some bytes to transmit (DCOUNT not 0)

Here we are looking at the wait time between XRDY/XDR and XUDF. Considering worst case scenarios, 

Wait_time = (time to transmit out XTRSH bytes from the FIFO at the slowest bus speed) + (safeguard delay)

The slowest bus speed appears in standard mode (100K bits/sec). Therefore,

Wait_time = [(XTRSH*8)*(1/100K)] seconds + constant;

Does this look correct?

 

--
Regards,
Nishanth Menon
