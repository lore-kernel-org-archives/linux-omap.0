From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Recent OMAP git broken on Beagle
Date: Tue, 13 May 2008 19:37:11 +0200
Message-ID: <4829D1C7.50200@googlemail.com>
References: <48254562.7000006@googlemail.com> <20080510180935.GA8121@atomide.com> <4825F542.1040906@googlemail.com> <alpine.DEB.1.00.0805121427150.25982@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:52159 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbYEMRfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 13:35:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2222461fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 10:35:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805121427150.25982@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, beagleboard@googlegroups.com

Paul Walmsley wrote:
> Hello Dirk,
> 
> On Sat, 10 May 2008, Dirk Behme wrote:
> 
> 
>>-- cut --
>>
>>>git bisect bad
>>
>>757f0b4ad6b0fd4377c2ee512fc595b5778aa3ac is first bad commit
>>commit 757f0b4ad6b0fd4377c2ee512fc595b5778aa3ac
>>Author: Paul Walmsley <paul@pwsan.com>
>>Date:   Fri May 9 14:45:24 2008 -0700
>>
>>    powerdomain: convert pwrdm_mutex to rwsem
> 
> 
> Curious, this boots fine on 3430sdp, and there's nothing in that patch 
> that should affect Beagle in particular.  
> 
> Could you try building cdda2a9adbc5421f4857e0313afc6c189f422e25 and see if 
> that also breaks?  

Hmm, I think cdda2a9a... was the first one working for me:

http://marc.info/?l=linux-omap&m=121040218707239&w=2

I started with  "git bisect good cdda2a9a..."

If you like, I can recheck again. But would be better if anybody else 
could confirm this, just in case I missed anything. Hint, hint ;)

> Of the recent OMAP-specific patches, that's the one 
> that I would suspect.  And if that also breaks, maybe try the one 
> before it, 352b2e24c5cd193a40ae376fec85665f2660aeb1 ?

In a private mail I got:

-- cut --
To add another data point:  on the OMAP3 EVM warm boots fail as 
described, but cold boots complete successfully.
-- cut --

Unfortunately, he couldn't confirm which commit is failing for him yet.

On Beagle we currently boot using bootrom starting from MMC. Like with 
TWL, it seems that the pre-initialization by bootrom has some 
influence on kernel behaviour.

Thanks

Dirk


