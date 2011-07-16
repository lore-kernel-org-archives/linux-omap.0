From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/2] TI816X: Add minimal hwmod data
Date: Sat, 16 Jul 2011 02:08:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107160139470.25013@utopia.booyaka.com>
References: <1303922002-6946-1-git-send-email-hemantp@ti.com> <alpine.DEB.2.00.1104281634050.11487@utopia.booyaka.com> <5F744A5A3C131242B81CE5874BD2CFFBBF8F8F14@dlee01.ent.ti.com> <alpine.DEB.2.00.1104282058370.11487@utopia.booyaka.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03AB5FAAAB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38736 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1GPIIZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jul 2011 04:08:25 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03AB5FAAAB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "Grosen, Mark" <mgrosen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Hemant,

On Wed, 13 Jul 2011, Pedanekar, Hemant wrote:

> Any comments on the hwmod and clock patch sets?

I haven't forgotten about these patches.

Here are a few questions:

- Are there are public documents about what interconnect is used on these 
chips?  Is it a SonicsMX, an Arteris NOC, or something else?

- It looks like you've grouped the PRCM implementation with the existing 
OMAP3 PRCM code.  But it appears to me, looking at the 816X TRM, that the
register layout is closer to OMAP4 - the MODULEMODE bits, etc.  Any 
comments on this?


- Paul
