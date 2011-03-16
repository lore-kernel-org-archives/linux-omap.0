From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Wed, 16 Mar 2011 12:17:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404E1F5369E@dbde02.ent.ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
	 <1299768675.2017.230.camel@deskari> <4D7967AB.1030404@openelec.tv>
	 <AANLkTimRnDhOah_J2wWQNLbf+WKX1VAsNm_HHGu24+6t@mail.gmail.com>
	 <1299828270.2567.6.camel@deskari>
	 <19F8576C6E063C45BE387C64729E739404E1F52DA7@dbde02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E739404E1F53077@dbde02.ent.ti.com>
	 <1300094686.2060.101.camel@lappyti>
	 <19F8576C6E063C45BE387C64729E739404E1F530B8@dbde02.ent.ti.com>
 <1300257914.1917.25.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab1CPGrr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 02:47:47 -0400
In-Reply-To: <1300257914.1917.25.camel@lappyti>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, Stephan Raue <mailinglists@openelec.tv>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Wednesday, March 16, 2011 12:15 PM
> To: Hiremath, Vaibhav
> Cc: K, Mythri P; Stephan Raue; linux-omap@vger.kernel.org
> Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
> 
> On Mon, 2011-03-14 at 04:35 -0500, Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: Valkeinen, Tomi
> > > Sent: Monday, March 14, 2011 2:55 PM
> > > To: Hiremath, Vaibhav
> > > Cc: K, Mythri P; Stephan Raue; linux-omap@vger.kernel.org
> > > Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
> 
> <snip>
> 
> > > > Personally I don't know any platform is implementing this function
> OR
> > > how one should make use of it. I remember last time we had similar
> > > discussion and the comment came was, restore only required in case of
> off
> > > mode. I feel, this is not applicable here, since irrespective of
> > > retention/inactive/off mode if driver is disabling clock for the
> > > peripheral we must restore the context.
> > >
> > > I don't know about OMAP4, but on OMAP3 the register contents are only
> > > lost when DSS goes to OFF mode. If you just turn off the clocks and
> OFF
> > > mode is not enabled in the PM, context restore is not needed. I am not
> > > sure of the current status of OFF mode in the mainline kernel.
> > >
> > > However, for some reason DSS works fine on my Overo board. I would
> > > imagine that it would break also if OFF is enabled for all omap
> > > boards...
> > >
> > > As for get_last_off_on_transaction_id(), it seems to be called
> > > get_context_loss_count() in the mainline kernel and returns u32, not
> > > int. I haven't tested it, but get_last_off_on_transaction_id pointer
> in
> > > the dss platform data should be set to get_context_loss_count in the
> > > board file (or in arch/arm/plat-omap/display.c if using the dss2 tree).
> > >
> > [Hiremath, Vaibhav] Let me try this out.
> 
> Did you have time to test this?
> 
[Hiremath, Vaibhav] Yesterday got pulled into different issue, will try today.

Thanks,
Vaibhav

>  Tomi
> 

