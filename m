From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri, 11 Mar 2011 09:24:30 +0200
Message-ID: <1299828270.2567.6.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
	 <1299768675.2017.230.camel@deskari> <4D7967AB.1030404@openelec.tv>
	 <AANLkTimRnDhOah_J2wWQNLbf+WKX1VAsNm_HHGu24+6t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab1CKHZG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 02:25:06 -0500
In-Reply-To: <AANLkTimRnDhOah_J2wWQNLbf+WKX1VAsNm_HHGu24+6t@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Stephan Raue <mailinglists@openelec.tv>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-11 at 00:16 -0600, K, Mythri P wrote:
> Hi Stephan,
> 
> On Fri, Mar 11, 2011 at 5:37 AM, Stephan Raue <mailinglists@openelec.tv> wrote:

> > thanks, this helps to boot the kernel. but now i get:
> >
> 
> <snip>
> 
> > see also: http://paste.pocoo.org/show/351648/
> >
> 
> I see that you kernel is not booting because of dss clk
>  [    3.335601] PC is at dss_clk_disable_no_ctx+0x0/0xa4
> [    3.335632] LR is at omap_dispc_register_isr+0xa4/0xcc
> Tomi is this related to the clock issue you were mentioning , which
> gets solved by adding a delay ?

Well, I have a hack patch in my tree which adds a delay of 10us. That
fixed the problem for me, but the 10us is just a random guess. It could
be that it needs to be longer wait. But this could be something else
also.

 Tomi


