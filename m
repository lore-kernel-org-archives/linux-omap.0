From: Paul Walmsley <paul@booyaka.com>
Subject: Re: Recent OMAP git broken on Beagle
Date: Mon, 12 May 2008 14:30:54 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805121427150.25982@utopia.booyaka.com>
References: <48254562.7000006@googlemail.com> <20080510180935.GA8121@atomide.com> <4825F542.1040906@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43452 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYELUaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 16:30:55 -0400
In-Reply-To: <4825F542.1040906@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, beagleboard@googlegroups.com

Hello Dirk,

On Sat, 10 May 2008, Dirk Behme wrote:

> -- cut --
> > git bisect bad
> 757f0b4ad6b0fd4377c2ee512fc595b5778aa3ac is first bad commit
> commit 757f0b4ad6b0fd4377c2ee512fc595b5778aa3ac
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Fri May 9 14:45:24 2008 -0700
> 
>     powerdomain: convert pwrdm_mutex to rwsem

Curious, this boots fine on 3430sdp, and there's nothing in that patch 
that should affect Beagle in particular.  

Could you try building cdda2a9adbc5421f4857e0313afc6c189f422e25 and see if 
that also breaks?  Of the recent OMAP-specific patches, that's the one 
that I would suspect.  And if that also breaks, maybe try the one 
before it, 352b2e24c5cd193a40ae376fec85665f2660aeb1 ?


- Paul
