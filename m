From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: DVFS: No sdrc AC timing changes during core dvfs
Date: Tue, 24 Nov 2009 15:35:05 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236DA1C1F3@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23806 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933083AbZKXOfv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 09:35:51 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com, b-cousson@ti.com, paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org

Hi,

Is there any update on this chain seeing this has been pending for a month now?

-Tero 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext 
>Woodruff, Richard
>Sent: 22 October, 2009 15:20
>To: Cousson, Benoit; Paul Walmsley; Nayak, Rajendra
>Cc: linux-omap@vger.kernel.org
>Subject: RE: [PATCH] OMAP3: DVFS: No sdrc AC timing changes 
>during core dvfs
>
>Hi Beonit,
>
>> From: Cousson, Benoit
>> Sent: Thursday, October 22, 2009 3:59 AM
>> To: Woodruff, Richard; Paul Walmsley; Nayak, Rajendra
>
>> >It is not guaranteed safe to write actim registers on the 
>fly to an active
>> >part.  It is safe to do RFR as it is buffered and sent out 
>at a safe time.
>>
>> I think that what Paul is suggesting is to change the ACTIM 
>after ensuring
>> that the DDR is in self-refresh. In that case it is 
>perfectly valid; it is
>> just tricky to ensure that all initiators are in mute before 
>doing that.
>
>Yes that is true, however, ...
>
>That is not the way the code is setup and it's a long way from 
>that.  Run time pause of drivers is a minefield.
>
>With out a broad notifier they best you would hope for is some 
>opportunistic change time (against full system).  You wouldn't 
>have a guaranteed way to speed them up again where you need 
>them most at high opp.
>
>Some minimal kernel not using dma and the like could do it but 
>that is probably more misleading to put in the tree than 
>something useful for most.
>
>Regards,
>Richard W.
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>