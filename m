From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Wed, 7 May 2014 10:59:20 -0700
Message-ID: <20140507175919.GH9502@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com>
 <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39312 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbaEGR70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 13:59:26 -0400
Content-Disposition: inline
In-Reply-To: <536A5920.1020908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 09:03]:
> On 07/05/14 18:03, Tony Lindgren wrote:
> 
> >>> +	lcd0: display {
> >>> +		compatible = "sharp,ls037v7dw01";
> >>> +		power-supply = <&lcd_3v3>;
> >>> +		reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
> >>> +		enable-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
> >>> +				&gpio1 2 GPIO_ACTIVE_HIGH	/* gpio2, lcd LR */
> >>> +				&gpio1 3 GPIO_ACTIVE_HIGH	/* gpio3, lcd UD */
> >>> +				&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
> >>
> >> Why are most of the gpios in 'enable-gpios'? MO, LR and UD don't really
> >> have anything to do with enabling the panel. Why not just have one
> >> 'gpios' array with all the gpios, as they are quite a mixed bunch?
> > 
> > Yeah that's what I had initially, but reading simple-panel.txt noticed
> > there are some standardized GPIOs for reset and enable.
> 
> I'm not sure if it's worth to try to make it compatible with
> simple-panel. simple-panel bindings do not work with omapdss anyway, and
> simple-panel doesn't have the support for input ports/endpoints.
> 
> Can the panel be used with only one gpio (I guess that would be INI or
> RESB)? If not, simple-panel doesn't work.

I guess in theory yes.
 
> > How about we set up one reset-gpios, one enable-gpios and an array of
> > three unlabelled GPIOs?
> > 
> > Or if we want to add something generic, we could add new mode-gpios
> > property that other panels might be able to use too?
> > 
> > BTW, I'm also personally fine with all five gpios showing in a single
> > gpios property, I'm not too exited about naming anything in DT..
> 
> I don't have a strong opinion here. I don't have much experience with
> DT, especially with making bindings compatible with other ones.
> 
> I'd just forget the simple-panel, and have single gpio array.

Well if it's a don't care flag for both of us, let's try to use
the existing standard for simple-panel.txt and add mode-gpios
property. I'll post a patch for that.

Regards,

Tony
