From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Tue, 11 Aug 2009 22:47:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908112245080.8886@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0306050246@dbde02.ent.ti.com> <alpine.DEB.2.00.0908111200560.17390@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5F00609@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34863 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbZHLErT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 00:47:19 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5F00609@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Hello Santosh,

On Wed, 12 Aug 2009, Shilimkar, Santosh wrote:

> > I'd also like to see the full names of the PRCM submodules, e.g.,
> > 
> > OMAP4430_CM2_RESTORE_CM2_MOD
> > 
> > rather than just
> > 
> > OMAP4430_CM2_RESTORE_MOD
> 
> Not sure what you mean by __full__ name here. You are adding a redundant CM2 in the name here.

Yes, for the above example, it looks pretty redundant, doesn't it.  But 
what about:

OMAP4430_PRM_WKUP_CM_MOD 

As my original message mentioned.

Do you still feel that is redundant?


- Paul
