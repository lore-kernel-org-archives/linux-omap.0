From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Mon, 28 Apr 2014 09:45:28 -0700
Message-ID: <20140428164528.GM20807@atomide.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com>
 <535A4470.2000509@ti.com>
 <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com>
 <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58646 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028AbaD1Qpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 12:45:33 -0400
Content-Disposition: inline
In-Reply-To: <535DFAAE.1010606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140427 23:53]:
> On 25/04/14 18:31, Tony Lindgren wrote:
> 
> > Chances are any mux register in the syscon area already works with
> > pinctrl-single,pins or pinctrl-single,bits option. The ones in the
> > padconf area should be already mapped so the driver just has to
> > request them.
> 
> If using the padconf (say omap4_padconf_global for omap4), doesn't that
> mean we need to have platform specific bits in the driver? Isn't that
> something we've been trying to remove all the time?

No, it's all done in a Linux generic way during driver probe, see
drivers/base/pinctrl.c. You just need to define the default pins
in the .dts files. If you need dynamic remuxing in the driver,
you can define other named states that the driver can then toggle
with pinctrl_select_state().

Regards,

Tony
