From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: Question on OPP table handling
Date: Tue, 6 Oct 2009 17:51:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE3DA1@dbde02.ent.ti.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>
	<4AC76810.1040206@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com>
 <87ws39zsn4.fsf@deeprootsystems.com> <4ACA2A86.7060300@ti.com>
 <74583B8642AB8841B30447520659FCA9DDAEF27A@dnce01.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC09146@dbde02.ent.ti.com>
 <4ACB2DAD.1090200@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC0936B@dbde02.ent.ti.com>
 <4ACB3243.409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57319 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756240AbZJFMVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 08:21:55 -0400
In-Reply-To: <4ACB3243.409@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin H <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Typo I meant Put all the OPP tables for different CPUs (instead ofOPPs) in __initdata. Copy the run time detected CPU's OPP table in memory. Others get discarded!"

>-----Original Message-----
>From: Menon, Nishanth
>Sent: Tuesday, October 06, 2009 5:34 PM
>To: Dasgupta, Romit
>Cc: Premi, Sanjeev; Cousson, Benoit; Kevin H; linux-omap@vger.kernel.org
>Subject: Re: Question on OPP table handling
>
>Dasgupta, Romit had written, on 10/06/2009 07:00 AM, the following:
>>> Couple of opinions on why a list with disabled/invalid marker might not
>>> make sense as a grand unified OPP table:
>>> a) it is no better than a list implementation
>>> b) it is a waste of memory.
>> [Romit] Put all the OPP tables for different OPPs in __initdata. Copy the runtime
>detected CPU's OPP table in memory. Others get discarded!
>>
>I like this approach.. takers?
>
>--
>Regards,
>Nishanth Menon
