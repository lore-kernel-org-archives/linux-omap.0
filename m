From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: Question on OPP table handling
Date: Tue, 6 Oct 2009 14:52:49 +0200
Message-ID: <74583B8642AB8841B30447520659FCA9DDAEF565@dnce01.ent.ti.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>
	<4AC76810.1040206@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com>
 <87ws39zsn4.fsf@deeprootsystems.com> <4ACA2A86.7060300@ti.com>
 <74583B8642AB8841B30447520659FCA9DDAEF27A@dnce01.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC09146@dbde02.ent.ti.com>
 <4ACB2DAD.1090200@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC0936B@dbde02.ent.ti.com>
 <4ACB3243.409@ti.com>
 <74583B8642AB8841B30447520659FCA9DDAEF4D6@dnce01.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC09388@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53419 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757178AbZJFMxa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 08:53:30 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDC09388@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Kevin H <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Dasgupta, Romit
> Sent: Tuesday, October 06, 2009 2:14 PM
> To: Cousson, Benoit; Menon, Nishanth
> Cc: Premi, Sanjeev; Kevin H; linux-omap@vger.kernel.org
> Subject: RE: Question on OPP table handling
> 
> >> Dasgupta, Romit had written, on 10/06/2009 07:00 AM, the following:
> >> >> Couple of opinions on why a list with disabled/invalid marker might
> not
> >> >> make sense as a grand unified OPP table:
> >> >> a) it is no better than a list implementation
> >> >> b) it is a waste of memory.
> >> > [Romit] Put all the OPP tables for different OPPs in __initdata. Copy
> >> the runtime detected CPU's OPP table in memory. Others get discarded!
> >> >
> >> I like this approach.. takers?
> >>
> >
> >I think it is not enough. Some OPPs will be selected based on runtime CPU
> >detection, but some OPPs might be disabled dynamically for some usecase
> >depending of external parameters.
> 
> [Romit] For a given SoC and type you can have only one OPP table. Isn't
> that true?

Yes, it is true but you might have to disable dynamically some OPP (like OPP5 and OPP4) for thermal management reason. The way the resource is handled today, you cannot force the reduction of the frequency in case of thermal issue.
I agree that there might be more elegant way to deal with that, but we can take advantage of disabling dynamically any OPP to do it.
