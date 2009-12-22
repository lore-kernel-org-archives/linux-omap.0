From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH v7 2/5] OMAP: McBSP: Modify macros/functions API for
 easy cache access
Date: Tue, 22 Dec 2009 14:28:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BFFDF8D5@dbde02.ent.ti.com>
References: <20091214193605.GC4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZLVI7T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 03:59:19 -0500
In-Reply-To: <20091214193605.GC4575@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>

 

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com] 
>Sent: Tuesday, December 15, 2009 1:06 AM
>To: Jarkko Nikula
>Cc: Janusz Krzysztofik; Varadarajan, Charu Latha; Peter 
>Ujfalusi; linux-omap@vger.kernel.org
>Subject: Re: [PATCH v7 2/5] OMAP: McBSP: Modify 
>macros/functions API for easy cache access
>
>* Jarkko Nikula <jhnikula@gmail.com> [091214 03:12]:
>> On Mon, 14 Dec 2009 11:11:27 +0100
>> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
>> 
>> > If these functions are obsolete and going to be removed, I 
>don't think it 
>> > could be of any importance whether they are modified 
>before removal or not. 
>> > Otherwise, a solution seems simple to me: you submit a 
>patch that addresses 
>> > all concearns, yours, Tony's (BTW, have you already 
>reviewed the drivers as 
>> > Tony suggested?), maybe others. Then, after your patch is 
>accepted for 
>> > inclusion and it appears in conflict with this series 
>still not applied for 
>> > any reason (possibly waiting for your changes if that 
>decided), Jarkko, or 
>> > Tony, or anyone else pointed out by Tony, decides which 
>one goes first and 
>> > which is going to be refreshed on top of the other. Does 
>it sound like a good 
>> > plan for you?
>> > 
>> I would favor the Janusz's set going in first since it will solve and
>> help the in-tree problems without making out-of-tree use any 
>worse than
>> currently.
>> 
>> - Fixes register access in polled I/O functions (out-of-tree use)
>> - Fixes McBSP register corruption noted on Amstrad Delta
>> - McBSP register caching could help the PM development
>> 
>> Fixing any other issues in polled I/O API belongs to another context
>> than this patch set and IMO is easier to handle after this 
>set since the
>> patch 1/5 already fixes the register access width.
>
>Sounds good to me.

Tony,
As pointed by you, the McBSP driver is having broken APIs. Please share your 
plans wrt McBSP driver. 
1) If there are plans to review and clean up the code,
we will focus on the same.
2) Else if the above is planned sometime in the future,
can you consider the patch for fixing McBSP poll mode
(http://patchwork.kernel.org/patch/54896/) as it is important to have a 
working code in place? If okay, I shall post a new version 
of the mentioned patch.

>
>Tony
>