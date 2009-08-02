From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Question about tput constraint on zoom2 camera
Date: Sat, 1 Aug 2009 20:57:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908012017340.14755@utopia.booyaka.com>
References: <F12EBA124C6E064B9CF1B45E67DDB7E77D4E028E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57509 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZHBC5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Aug 2009 22:57:43 -0400
In-Reply-To: <F12EBA124C6E064B9CF1B45E67DDB7E77D4E028E@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Curran, Dominic" <dcurran@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Subramaniam, Muthu" <muthu@ti.com>

Hello Dominic,

On Fri, 31 Jul 2009, Curran, Dominic wrote:

> I have been testing the zoom2 camera streaming while using different OPP's.
> Following table provides summary of what OPP's caused to happen:
> 
>   Streaming      Vdd1(OPP)        Vdd2(OPP)           P/F
>  VGA @ 30fps           1                2             Pass
>  8MP @ 7.5fps          1                2             Fails (stop streaming)
>  8MP @ 7.5fps          1                3             Pass
> 
> So table shows that locking Vdd2 to OPP=3 when streaming 8MPixel works, but at OPP=2 then streaming fails (stops).
> 
> So I thought the tput constraint made the most sense for camera.
> The Zoom2 camera sensor has a max tput of:
> 
>     3280 x 2464 x 2bpp x 7.5fps = 121228800 bytes/s
>                                 = 118387 KB/s
> 
> However, this calculated value doesn't constrain Vdd2 to OPP3 (DVFS enabled).
> 
> Experimentation shows that a tput value of 350000 KB/s is required to constrain Vdd2 to OPP=3.
>
> Can you explain why the practical tput constraint is so much greater than the theoretical value ?

Probably it is mostly due to two reasons: 

1. most other L3 initiator drivers (eg., for DSS, SDMA, USB, etc) don't 
currently set bus throughput constraints, so we aren't currently adding in 
their interconnect usage; and

2. the interconnect throughput model in omap-pm-srf.c is optimistic.

A couple of questions for you: (please forgive my ignorance of the camera 
subsystem):

A. What other L3 initiators are active during the test?  Presumably DSS, 
MPU?  IVA2?

B. I am assuming you are using the CCP2.  What do you have CCP2_CTRL.BURST 
set to?  This could impact interconnect utilization.


- Paul


