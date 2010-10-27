From: "Taneja, Archit" <archit@ti.com>
Subject: RE: Requirement for DSI video mode support
Date: Wed, 27 Oct 2010 13:47:51 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BD6BCCE@dbde02.ent.ti.com>
References: <AANLkTikBn63Y1CofZksexds7tBqzxrNvX3MD=tZ49hDw@mail.gmail.com>
	 <1286532774.28499.1088.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087034BD6BBEE@dbde02.ent.ti.com>
 <1288163876.2580.160.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57613 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab0J0ISB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 04:18:01 -0400
In-Reply-To: <1288163876.2580.160.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Jorge Bustamante <jbustamante.init@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Iovescu, Magdalena" <m-iovescu1@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Qassid, Youcef" <y-qassid@ti.com>, "Aguirre, Alberto" <a-aguirre@ti.com>

Hi,

>> 
>> Command mode panels will work fine with a single VC, I don't think
>> video mode can run by using only one VC.
> 
> Okay, I think we're talking about different VCs =). It's
> rather confusing in the TRM. A VC (in DSI packet sense)
> refers to the channel ID sent in the packet, and a VC (in
> OMAP DSS register sense) refers to a set of configurations
> used to send DSI packets. I think we need to come up with
> terms that clearly make the distinction between these,
> because they really don't have anything in common. (I'd like
> to hear the rationale for naming OMAP's config registers as VCs... =).
> 

Yeah, it took me a while to figure out the difference from the TRM too.

As far as the driver is concerned, I think there was a "dest_per" member
for each set of VC configurations, that really made things clear.

Its not in the present kernel, but it would be nice to get it back. The
present approach always correlates VC0 configuration to VC_ID 0,
1 to 1 and so on. That confused me for a while again :|

>> Also, for command mode, there isn't a restriction to use a single VC.
>> If you configure one VC to have slave port as source and the other as
>> video port, the need to switch the VC source between L4 and VP would go away.
> 
> This was what I had at some point. However, I was unsure how
> transmissions are synchronized in that case. If there's
> transmission going on from VP via, say, VC0, and I send a
> message from L4 via VC1, what happens? Does VC1 wait until
> VC0 is done? Or does it send the packet between VC0's packets?
> 

I don't know how things works internally, but I am sure the 2 VC
configuration works for a handful of phones :)

Is this a thing that should be explained in the DSI specification, or
is this something that should be taken care of while implementing DSI
hardware? I'll try to find out.

> But I agree, different VCs for L4 and VP usage would make
> some things a bit simpler.
> 
>> The most optimal way would be to use one VC for each peripheral, but I
>> don't think the usecase of connecting 4 panels to the same
> DSI lanes would ever be needed.
> 
> Yes, that is quite unlikely. But it's difficult to say what
> kind of devices one needs to connect (see below), but it
> could be that we may come up with some kind of rules that fit
> to all cases.
> 
> For example, is there ever need to have to OMAP VCs
> configured as VP at the same time? If not, we know that there
> will always be 3 OMAP VCs free for L4 use. Etc. (I didn't
> think this really, just throwing ideas =).
> 

Yes it would be good to more of such rules. I don't think the
one above is valid for OMAP4 though. One of the DSI blocks has
2 video ports as input. One VC can be configured in Video mode + Video Port
and the other can be Command mode + Video port, and command mode and video
port can run together. We haven't tried it out yet (and don't want to either :))

>>> 
>>> Nevertheless, it should be possible to use multiple VCs in one driver.
>>> I've implemented a driver for a buffer chip that used all 4 channels.
>> 
>> So did you connect more than one panel to DSI? I am curious about how
>> it works
> 
> The chip had it's own framebuffer memory, and you could
> connect two displays to the chip. The virtual channel mapping
> was something like
> this:
> 0 - routed to first panel
> 1 - routed to second panel
> 2 - buffer chip config
> 3 - buffer chip framebuffer config
> 

That's interesting, slightly out of topic question: How would a
buffer chip / LVDS bridge chip fit in the DSS2 fw. Should it be in the
panel driver or have its own driver? Asking out of curiosity.

Regards,

Archit