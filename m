From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Mon, 2 May 2011 08:48:48 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B09CF68@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
	<20110429170409.5ad8833b.jhnikula@gmail.com>
	<9D0D31AA57AAF5499AFDC63D6472631B09CE3E@008-AM1MPN1-036.mgdnok.nokia.com>
 <20110502095727.7f679550.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:29891 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756907Ab1EBItj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 04:49:39 -0400
In-Reply-To: <20110502095727.7f679550.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jhnikula@gmail.com
Cc: tony@atomide.com, Sakari.Ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com

Hi,

 > -----Original Message-----
 > From: ext Jarkko Nikula [mailto:jhnikula@gmail.com]
 > Sent: 2. toukokuuta 2011 9:57
 > To: Jokiniemi Kalle (Nokia-SD/Tampere)
 > Cc: tony@atomide.com; Ailus Sakari (Nokia-SD/Helsinki); linux-
 > omap@vger.kernel.org; lrg@slimlogic.co.uk;
 > broonie@opensource.wolfsonmicro.com
 > Subject: Re: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
 > 
 > On Mon, 2 May 2011 05:19:46 +0000
 > <kalle.jokiniemi@nokia.com> wrote:
 > 
 > > It seems I was not answering your question quite rightly... So these are used
 > > to power some internal blocks inside the TWL5030. The dependencies there
 > > are not very well documented, so it's best to leave them be. I think these
 > > could be turned off via the power scripts during OFF mode (if we would be
 > > using that).
 > >
 > Sounds safe assumption for those two. Also I don't point out from
 > public schematics where are the vintana2 and vpll2 routed so looks like
 > need keep them on as well.

In case you're interested, the high level routings are listed in the TPS65950
TRM: http://focus.ti.com/lit/ug/swcu050g/swcu050g.pdf 
See chapter 6.3, figure 6-3.

- Kalle

 > 
 > --
 > Jarkko
