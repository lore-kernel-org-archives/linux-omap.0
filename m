From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Wed, 12 Aug 2009 10:39:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0306050331@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0908112245080.8886@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36919 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbZHLFJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 01:09:42 -0400
In-Reply-To: <alpine.DEB.2.00.0908112245080.8886@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Paul, 

>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: Wednesday, August 12, 2009 10:17 AM
>To: Shilimkar, Santosh
>Cc: Nayak, Rajendra; linux-arm-kernel@lists.arm.linux.org.uk; 
>linux-omap@vger.kernel.org; Cousson, Benoit; sakari.poussa@nokia.com
>Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets 
>for OMAP4
>
>Hello Santosh,
>
>On Wed, 12 Aug 2009, Shilimkar, Santosh wrote:
>
>> > I'd also like to see the full names of the PRCM submodules, e.g.,
>> > 
>> > OMAP4430_CM2_RESTORE_CM2_MOD
>> > 
>> > rather than just
>> > 
>> > OMAP4430_CM2_RESTORE_MOD
>> 
>> Not sure what you mean by __full__ name here. You are adding 
>a redundant CM2 in the name here.
>
>Yes, for the above example, it looks pretty redundant, doesn't 
>it.  But 
>what about:
>
>OMAP4430_PRM_WKUP_CM_MOD 

There are only 2 such instances of these where in WKUP_CM and EMU_CM and
part of PRM module. There are no such instances in CM1 or CM2.
To take care of 2 of these we would have 60 odd which would look redundant
and module names as along as this OMAP4430_PRM_ALWAYS_ON_PRM_MOD.

If its really confusing and hard to remember that these belong to PRM we can always 
have exceptions in naming, and we have had exceptions in
3430 as well. There are modules common to 2430/3430 which are named differently
as well as modules only in ES2 which are named differently.

>
>As my original message mentioned.
>
>Do you still feel that is redundant?
>
>
>- Paul
>
>