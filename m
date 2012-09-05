From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] pinctrl: pinctrl-single: new type:
 pinctrl-single,bits
Date: Wed, 5 Sep 2012 11:20:24 -0700
Message-ID: <20120905182023.GG1303@atomide.com>
References: <1346835718-21325-1-git-send-email-peter.ujfalusi@ti.com>
 <CACRpkda9_qK9jrJSAYo5NDiadrX2-J5mgMapY6pp__XzanUhZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22701 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab2IESU1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 14:20:27 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkda9_qK9jrJSAYo5NDiadrX2-J5mgMapY6pp__XzanUhZA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [120905 05:11]:
> On Wed, Sep 5, 2012 at 11:01 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> > When configuring pinmux with pinctrl-single there could be a case when one
> > register is used to configure mux for more than one pin.
> > In this case the use of pinctrl-single,pins is a bit problematic since we can
> > only update the whole register (restricted by the mask).
> > In such a situations the pinctrl-single,bits could provide a safe way to handle
> > the mux.
> >
> > pinctrl-single,bits takes three parameters: <reg offset, value, sub-mask>
> > The sub mask is used to mask part of the register to make sure we do not change
> > bits outside of the scope of this pin.
> >
> > The first patch in this series is to fix the previous pinctrl-since,pins
> > implementation because it was not using the mask on the value which could result
> > changed bits outside of the mask.
> 
> This looks sane to me, but I'd like Tony to ACK before I apply it.

Cool, this should allow handling cases where some pinctrl devices can have
extra aux registers for signal strength etc for some of the pins.

Will take a look.

Tony
