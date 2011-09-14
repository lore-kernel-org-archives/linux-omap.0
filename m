From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: RE: OMAP3505 revisions?
Date: Wed, 14 Sep 2011 22:04:57 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087037AF843E2@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1109131157520.1885@utopia.booyaka.com>
 <B85A65D85D7EB246BE421B3FB0FBB593025750A2A5@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1109140539230.27954@utopia.booyaka.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302575A00A6@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1109140746410.27954@utopia.booyaka.com>,<B85A65D85D7EB246BE421B3FB0FBB59302575A016A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54836 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756502Ab1INQgU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 12:36:20 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302575A016A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "notasas@gmail.com" <notasas@gmail.com>, "tony@atomide.com" <tony@atomide.com>, Igor Grinberg <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul 

On Wed, Sep 14, 2011 at 7:21 PM, Premi, Sanjeev wrote:
>
> ________________________________________
>> -----Original Message-----
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Wednesday, September 14, 2011 7:19 PM
>> To: Premi, Sanjeev
>> Cc: notasas@gmail.com; tony@atomide.com; Igor Grinberg;
>> linux-omap@vger.kernel.org
>> Subject: RE: OMAP3505 revisions?
>>
>> On Wed, 14 Sep 2011, Premi, Sanjeev wrote:
>>
>> > > -----Original Message-----
>> > > From: Paul Walmsley [mailto:paul@pwsan.com]
>> > > Sent: Wednesday, September 14, 2011 5:11 PM
>> > > To: Premi, Sanjeev
>> > > Cc: notasas@gmail.com; tony@atomide.com;
>> linux-omap@vger.kernel.org
>> > > Subject: RE: OMAP3505 revisions?
>> > >
>> > > Thanks.  Could you try a test boot of the
>> 'id_3517_cleanup_3.2' branch
>> > > of git://git.pwsan.com/linux-2.6 on an AM3517/3505, or
>> ask someone to
>> > > try that out?
>> >
>> > Sure I will get this tested.
[Abhilash K V] I just tried this branch on a AM3517 and it boots after
applying this patch-set:
http://marc.info/?l=linux-omap&m=131410578024030&w=2

- Abhilash
>>
>> I just repushed this branch with changes to fix a bug that
>> Igor found.
>> If you've pulled it already, could you re-pull?  I'm particularly
>> interested in a test on a 3505 board.
>
> [sp] The pull is in progress (... bit slow).
>     Not sure if we have a AM3505 board, but it can be simulated.
>
> ~sanjeev
>
>>
>>
>> - Paul
>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

