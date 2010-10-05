From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog,
 UART, i2c
Date: Tue, 5 Oct 2010 00:24:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010050023580.13816@utopia.booyaka.com>
References: <8762xpenf8.fsf@deeprootsystems.com> <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com> <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com> <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com> <4CA60F88.4020303@ti.com> <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com> <0680EC522D0CC943BC586913CF3768C003FF3B2C94@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55586 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab0JEGYf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:24:35 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF3B2C94@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Hi Rajendra,

On Tue, 5 Oct 2010, Nayak, Rajendra wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, October 05, 2010 11:32 AM
> > 
> > Some IP blocks may require extra time to become ready for register
> > reads/writes after the PRCM deasserts its IdleAck signal to the
> 
> Maybe it should say 'PRCM deasserts its IdleReq'

Oops, yes, you are right; will fix and repost an updated version.


- Paul
