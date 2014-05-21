From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Wed, 21 May 2014 07:50:54 -0700
Message-ID: <20140521145053.GG17417@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com>
 <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com>
 <536C7EA7.5000306@ti.com>
 <20140509153723.GD17814@atomide.com>
 <20140513213205.GB18001@atomide.com>
 <537C9FC6.8020104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45682 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751018AbaEUOvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 10:51:00 -0400
Content-Disposition: inline
In-Reply-To: <537C9FC6.8020104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joachim Eastwood <manabian@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:45]:
> On 14/05/14 00:32, Tony Lindgren wrote:
> 
> > +&dss {
> > +	status = "ok";
> > +	vdds_dsi-supply = <&vpll2>;
> > +	port {
> > +		dpi_out: endpoint {
> > +			remote-endpoint = <&lcd_in>;
> > +			data-lines = <18>;
> > +		};
> > +	};
> > +};
> 
> I just noticed the vdds_dsi-supply there. While the driver currently
> uses that if available, I think it should be removed, and done the same
> way Florian did with his overo patches:
> 
> /* Needed to power the DPI pins */
> &vpll2 {
> 	regulator-always-on;
> };
> 
> That supply is not DSS's supply, but it's used to power up the pins. If
> the pins were used as GPIOs, that power should be enabled.

OK thanks for catching it.

Regards,

Tony
