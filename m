From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: PM branch rebased to 2.6.29
Date: Mon, 30 Mar 2009 18:52:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC569BCD@dbde02.ent.ti.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
 <1237914611.23022.124.camel@blackhole> <87zlfaztcd.fsf@deeprootsystems.com>
 <1237925484.23022.133.camel@blackhole>
 <49C940CA.9070805@deeprootsystems.com>
 <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
 <B71C5453-5BD7-4A43-BCEC-F4BFACBF1DC1@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51671 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbZC3NW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 09:22:26 -0400
In-Reply-To: <B71C5453-5BD7-4A43-BCEC-F4BFACBF1DC1@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Monday, March 30, 2009 4:12 PM
> To: linux-omap@vger.kernel.org Mailing List
> Subject: Re: PM branch rebased to 2.6.29
> 
> Op 30 mrt 2009, om 12:08 heeft Premi, Sanjeev het volgende geschreven:
> 
> > I had found that two drivers that could prevent clocks_off are
> > USB and DSS because of the way they use clk_enable().
> 
> How does DSS2 behave in that regard, and is there any effort 
> in fixing  
> the MUSB and EHCI drivers?

The problem has already been fixed in DSS2. Vaibhav had discussed it
a few weeks back on the list.

I am aware of the effory for USB, EHCI effort... but not the timelines.

~sanjeev
> 
> regards,
> 
> Koen
> 