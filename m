From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri, 11 Mar 2011 18:53:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404E1F52DA7@dbde02.ent.ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
	 <1299768675.2017.230.camel@deskari> <4D7967AB.1030404@openelec.tv>
	 <AANLkTimRnDhOah_J2wWQNLbf+WKX1VAsNm_HHGu24+6t@mail.gmail.com>
 <1299828270.2567.6.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab1CKNXN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 08:23:13 -0500
In-Reply-To: <1299828270.2567.6.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "K, Mythri P" <mythripk@ti.com>
Cc: Stephan Raue <mailinglists@openelec.tv>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Valkeinen, Tomi
> Sent: Friday, March 11, 2011 12:55 PM
> To: K, Mythri P
> Cc: Stephan Raue; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
> 
> On Fri, 2011-03-11 at 00:16 -0600, K, Mythri P wrote:
> > Hi Stephan,
> >
> > On Fri, Mar 11, 2011 at 5:37 AM, Stephan Raue <mailinglists@openelec.tv>
> wrote:
> 
> > > thanks, this helps to boot the kernel. but now i get:
> > >
> >
> > <snip>
> >
> > > see also: http://paste.pocoo.org/show/351648/
> > >
> >
> > I see that you kernel is not booting because of dss clk
> >  [    3.335601] PC is at dss_clk_disable_no_ctx+0x0/0xa4
> > [    3.335632] LR is at omap_dispc_register_isr+0xa4/0xcc
> > Tomi is this related to the clock issue you were mentioning , which
> > gets solved by adding a delay ?
> 
> Well, I have a hack patch in my tree which adds a delay of 10us. That
> fixed the problem for me, but the 10us is just a random guess. It could
> be that it needs to be longer wait. But this could be something else
> also.
> 
>  Tomi
> 
[Hiremath, Vaibhav] Tomi, just thought of updating you,

The linux-omap/dss2 OMAP3EVM seems to be broken, I am trying to debug this at the moment and will update about my findings.

Since linux-omap/master is booting up fine, it looks like one of new DSS patch leading to this.

Thanks,
Vaibhav

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
