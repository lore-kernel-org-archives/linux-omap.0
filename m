From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Mon, 14 Mar 2011 15:05:24 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404E1F530B8@dbde02.ent.ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
	 <1299768675.2017.230.camel@deskari> <4D7967AB.1030404@openelec.tv>
	 <AANLkTimRnDhOah_J2wWQNLbf+WKX1VAsNm_HHGu24+6t@mail.gmail.com>
	 <1299828270.2567.6.camel@deskari>
	 <19F8576C6E063C45BE387C64729E739404E1F52DA7@dbde02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E739404E1F53077@dbde02.ent.ti.com>
 <1300094686.2060.101.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43571 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab1CNJfg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 05:35:36 -0400
In-Reply-To: <1300094686.2060.101.camel@lappyti>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, Stephan Raue <mailinglists@openelec.tv>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Monday, March 14, 2011 2:55 PM
> To: Hiremath, Vaibhav
> Cc: K, Mythri P; Stephan Raue; linux-omap@vger.kernel.org
> Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
> 
> On Mon, 2011-03-14 at 03:35 -0500, Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Hiremath, Vaibhav
> > > Sent: Friday, March 11, 2011 6:53 PM
> > > To: Valkeinen, Tomi; K, Mythri P
> > > Cc: Stephan Raue; linux-omap@vger.kernel.org
> > > Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
> > >
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of Valkeinen, Tomi
> > > > Sent: Friday, March 11, 2011 12:55 PM
> > > > To: K, Mythri P
> > > > Cc: Stephan Raue; linux-omap@vger.kernel.org
> > > > Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
> > > >
> > > > On Fri, 2011-03-11 at 00:16 -0600, K, Mythri P wrote:
> > > > > Hi Stephan,
> > > > >
> > > > > On Fri, Mar 11, 2011 at 5:37 AM, Stephan Raue
> > > <mailinglists@openelec.tv>
> > > > wrote:
> > > >
> > > > > > thanks, this helps to boot the kernel. but now i get:
> > > > > >
> > > > >
> > > > > <snip>
> > > > >
> > > > > > see also: http://paste.pocoo.org/show/351648/
> > > > > >
> > > > >
> > > > > I see that you kernel is not booting because of dss clk
> > > > >  [    3.335601] PC is at dss_clk_disable_no_ctx+0x0/0xa4
> > > > > [    3.335632] LR is at omap_dispc_register_isr+0xa4/0xcc
> > > > > Tomi is this related to the clock issue you were mentioning ,
> which
> > > > > gets solved by adding a delay ?
> > > >
> > > > Well, I have a hack patch in my tree which adds a delay of 10us.
> That
> > > > fixed the problem for me, but the 10us is just a random guess. It
> could
> > > > be that it needs to be longer wait. But this could be something else
> > > > also.
> > > >
> > > >  Tomi
> > > >
> > > [Hiremath, Vaibhav] Tomi, just thought of updating you,
> > >
> > > The linux-omap/dss2 OMAP3EVM seems to be broken, I am trying to debug
> this
> > > at the moment and will update about my findings.
> > >
> > > Since linux-omap/master is booting up fine, it looks like one of new
> DSS
> > > patch leading to this.
> > >
> > [Hiremath, Vaibhav] I think I found the where and why the kernel is
> crashing but not sure about root-cause -
> >
> > The root-cause turned out to be -
> >
> > void dss_clk_enable(enum dss_clock clks)
> > {
> > ...
> >
> > if (check_ctx && cpu_is_omap34xx() && dss_need_ctx_restore())
> >        restore_all_ctx();
> > ...
> > }
> >
> > In this case, restore never happens, if I understand correctly, I am
> expecting, the context must be restored when all clock (especially
> interface clock) is disabled.
> > In order to do this, dss_need_ctx_restore must be implemented here,
> which I think should be ORed with other conditions.
> >
> > if (cpu_is_omap34xx() && (check_ctx || dss_need_ctx_restore()))
> >
> > (This results in kernel crash at my end)
> >
> > Personally I don't know any platform is implementing this function OR
> how one should make use of it. I remember last time we had similar
> discussion and the comment came was, restore only required in case of off
> mode. I feel, this is not applicable here, since irrespective of
> retention/inactive/off mode if driver is disabling clock for the
> peripheral we must restore the context.
> 
> I don't know about OMAP4, but on OMAP3 the register contents are only
> lost when DSS goes to OFF mode. If you just turn off the clocks and OFF
> mode is not enabled in the PM, context restore is not needed. I am not
> sure of the current status of OFF mode in the mainline kernel.
> 
> However, for some reason DSS works fine on my Overo board. I would
> imagine that it would break also if OFF is enabled for all omap
> boards...
> 
> As for get_last_off_on_transaction_id(), it seems to be called
> get_context_loss_count() in the mainline kernel and returns u32, not
> int. I haven't tested it, but get_last_off_on_transaction_id pointer in
> the dss platform data should be set to get_context_loss_count in the
> board file (or in arch/arm/plat-omap/display.c if using the dss2 tree).
> 
[Hiremath, Vaibhav] Let me try this out.

Thanks,
Vaibhav

>  Tomi
> 

