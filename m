From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Mon, 2 May 2011 04:54:16 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B09CE21@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
 <20110430192347.GB16378@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:25743 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab1EBEy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 00:54:28 -0400
In-Reply-To: <20110430192347.GB16378@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: tony@atomide.com, Sakari.Ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

Hi,

 > -----Original Message-----
 > From: ext Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
 > Sent: 30. huhtikuuta 2011 22:24
 > To: Jokiniemi Kalle (Nokia-SD/Tampere)
 > Cc: tony@atomide.com; Ailus Sakari (Nokia-SD/Helsinki); linux-
 > omap@vger.kernel.org; lrg@slimlogic.co.uk
 > Subject: Re: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
 > 
 > On Fri, Apr 29, 2011 at 03:47:44PM +0300, Kalle Jokiniemi wrote:
 > 
 > > +		.always_on		= true,
 > > +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 > > +					| REGULATOR_MODE_STANDBY,
 > > +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 > > +					| REGULATOR_CHANGE_STATUS,
 > 
 > _CHANGE_STATUS doesn't make much sense in conjunction with always_on.
 > Otherwise this looks OK to me.

Ok, I'll remove those. Thanks.

- Kalle
