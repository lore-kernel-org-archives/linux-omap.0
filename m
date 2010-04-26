From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2 V6] OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
Date: Mon, 26 Apr 2010 20:23:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E1EBEED@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E304C@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044E1EBEB2@dbde02.ent.ti.com>
 <8B4456C7-B8B1-47C6-A4D4-89BDB31B740E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52161 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab0DZOxb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 10:53:31 -0400
In-Reply-To: <8B4456C7-B8B1-47C6-A4D4-89BDB31B740E@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Koen Kooi [mailto:koen@dominion.thruhere.net]
> Sent: Monday, April 26, 2010 8:21 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org List
> Subject: Re: [PATCH 2/2 V6] OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
> 
> 
> Op 26 apr 2010, om 15:27 heeft Hiremath, Vaibhav het volgende geschreven:
> 
> >>
> >> +CONFIG_FRAMEBUFFER_CONSOLE=y
> > [Hiremath, Vaibhav] Are you sure you want FRAMEBUFFER_CONSOLE option to be
> enabled here? This actually brings a dark cursor on display which is
> annoying. Atleast I have seen multiple request in the past to remove this
> option from field.
> 
> Can't you setterm that cursor off? I have fbcon enabled and don't see that
> cursor. 

[Hiremath, Vaibhav] Yes we can do that, but its addition step required.

> And please trim your replies, it is getting annoying to pinpoint
> replies between a gazillion unrelated lines of patch.
[Hiremath, Vaibhav] Opps, actually I have set my outlook to trim it
automatically for 78 characters, not sure how that happened.

Thanks,
Vaibhav

> 
> regards,
> 
> Koen
