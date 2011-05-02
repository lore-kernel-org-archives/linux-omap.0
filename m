From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Mon, 2 May 2011 05:19:46 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B09CE3E@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
 <20110429170409.5ad8833b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:46101 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968Ab1EBFUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 01:20:08 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jhnikula@gmail.com
Cc: tony@atomide.com, Sakari.Ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com



 > -----Original Message-----
 > From: Jokiniemi Kalle (Nokia-SD/Tampere)
> 
 > Hi,
 > 
 >  > -----Original Message-----
 >  > From: ext Jarkko Nikula [mailto:jhnikula@gmail.com]
 >  > Sent: 29. huhtikuuta 2011 17:04
 >  > To: Jokiniemi Kalle (Nokia-SD/Tampere)
 >  > Cc: tony@atomide.com; Ailus Sakari (Nokia-SD/Helsinki); linux-
 >  > omap@vger.kernel.org; lrg@slimlogic.co.uk;
 >  > broonie@opensource.wolfsonmicro.com
 >  > Subject: Re: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
 >  >
 >  > On Fri, 29 Apr 2011 15:47:44 +0300
 >  > Kalle Jokiniemi <kalle.jokiniemi@nokia.com> wrote:
 >  >
 >  > > +static struct regulator_init_data rx51_vintana1 = {
 >  > > +	.constraints = {
 >  > > +		.name			= "VINTANA1",
 >  > > +		.min_uV			= 1500000,
 >  > > +		.max_uV			= 1500000,
 >  > > +		.always_on		= true,
 >  > ...
 >  > > +static struct regulator_init_data rx51_vintdig = {
 >  > > +	.constraints = {
 >  > > +		.name			= "VINTDIG",
 >  > > +		.min_uV			= 1500000,
 >  > > +		.max_uV			= 1500000,
 >  > > +		.always_on		= true,
 >  >
 >  > Are these two used at all? According to public schematics they are
 >  > connected to just one capasitor. Could be some needed filtering/charge
 >  > pump capacitors for TWL though.

It seems I was not answering your question quite rightly... So these are used
to power some internal blocks inside the TWL5030. The dependencies there
are not very well documented, so it's best to leave them be. I think these
could be turned off via the power scripts during OFF mode (if we would be
using that).

- Kalle

 >  >
 >  > I was thinking are all of these regulators really always_on? How about
 >  > letting those without any known user to be switched off?
 > 
 > In a working environment, these regulators were on. If you let all regulators
 > get disabled, you'll just be asking for trouble.
 > 
 > Here's the initial discussion how this patch came about:
 > http://www.mail-archive.com/linux-media@vger.kernel.org/msg30775.html

