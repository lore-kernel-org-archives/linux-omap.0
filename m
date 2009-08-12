From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Wed, 12 Aug 2009 10:07:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5F00609@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0306050246@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0908111200560.17390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35954 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbZHLEiE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 00:38:04 -0400
In-Reply-To: <alpine.DEB.2.00.0908111200560.17390@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>


Paul,

> I'd also like to see the full names of the PRCM submodules, e.g.,
> 
> OMAP4430_CM2_RESTORE_CM2_MOD
> 
> rather than just
> 
> OMAP4430_CM2_RESTORE_MOD

Not sure what you mean by __full__ name here. You are adding a redundant CM2 in the name here.

Regards,
Santosh
