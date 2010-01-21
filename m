From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [ANNOUNCE] rebased dspbridge-pm on top of dspbridge
Date: Thu, 21 Jan 2010 10:02:23 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DF3B5FB@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53042DF3B315@dlee03.ent.ti.com>
 <20100121131816.GA3787@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50383 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab0AUQDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 11:03:50 -0500
In-Reply-To: <20100121131816.GA3787@annwn.felipec.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Nishanth Menon <menon.nishanth@gmail.com>, Tony Lindgren <tony@atomide.com>



>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@nokia.com]
>Sent: Thursday, January 21, 2010 7:18 AM
>To: Ramirez Luna, Omar
>Cc: linux-omap; Ameya Palande; Hiroshi Doyu; Nishanth Menon; Tony Lindgren
>Subject: Re: [ANNOUNCE] rebased dspbridge-pm on top of dspbridge
>
>On Thu, Jan 21, 2010 at 01:19:52AM +0100, Omar Ramirez Luna wrote:
>> dspbridge-pm branch was rebased on top of latest dspbridge, so please
>> update your local branches.
>>
>> As a reminder:
>> 	dspbridge is based on top of 2.6.32 LO
>
>I remember Tony explained that branches should be based on top of
>mainstream, not l-o. Moreover, I see no reason to depend on l-o;
>everything dspbridge needs is already in mainstream.

My bad, meant 2.6.32 not LO specific.

commit 22763c5cf3690a681551162c15d34d935308c8d7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Dec 2 19:51:21 2009 -0800

    Linux 2.6.32

- omar
