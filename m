From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Tue, 11 Aug 2009 23:46:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908112344470.8886@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030605036C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47193 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbZHLFqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 01:46:50 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030605036C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Hi Rajendra,

On Wed, 12 Aug 2009, Nayak, Rajendra wrote:

> >There are only 2 such instances of these where in WKUP_CM and 
> >EMU_CM and
> >part of PRM module. There are no such instances in CM1 or CM2.
> >To take care of 2 of these we would have 60 odd which would 
> >look redundant
> >and module names as along as this OMAP4430_PRM_ALWAYS_ON_PRM_MOD.
> 
> Just to be clear what I mean..

> this is what it would look like with 2 exceptions

...

> And this with your way of naming..

...

> And this is just for the PRM modules, there would be all modules in CM1 
> and CM2 with redundunt additional CM1/CM2 even though there are no 
> exceptions there.

Yes, sure, I get your point.

Whatever we do, it should be as consistent as possible, and it should be 
behavior that can be rationally programmed into the autogeneration 
scripts.


- Paul
