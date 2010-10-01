From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog,
 UART, i2c
Date: Fri, 1 Oct 2010 17:48:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010011746560.22941@utopia.booyaka.com>
References: <8762xpenf8.fsf@deeprootsystems.com> <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com> <20100930021819.GD3117@atomide.com> <20100930022937.GF3117@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010011737250.22941@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49525 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab0JAXsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:48:36 -0400
In-Reply-To: <alpine.DEB.2.00.1010011737250.22941@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, 1 Oct 2010, Paul Walmsley wrote:

> OMAP1 doesn't have a SCM, so this is the wrong fix.  A better approach is 
> here:
> 
> https://patchwork.kernel.org/patch/218992/

Sorry, cut and paste error, should have been

    http://marc.info/?l=linux-omap&m=128596931417802&w=2


thanks to Kevin for letting me know -

- Paul
