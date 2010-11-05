From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] cbus: tahvo: move platform_device to board file
Date: Fri, 5 Nov 2010 09:36:02 -0700
Message-ID: <20101105163602.GJ9264@atomide.com>
References: <1285936419-28426-1-git-send-email-balbi@ti.com>
 <1285936419-28426-4-git-send-email-balbi@ti.com>
 <20101001123737.GT2925@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63332 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab0KEQgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:36:16 -0400
Content-Disposition: inline
In-Reply-To: <20101001123737.GT2925@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [101001 05:29]:
> On Fri, Oct 01, 2010 at 07:33:38AM -0500, Balbi, Felipe wrote:
> >@@ -255,9 +269,24 @@ static void __init n8x0_cbus_init(void)
> >		return;
> >	}
> >
> >-	set_irq_type(gpio_to_irq(108), IRQ_TYPE_EDGE_RISING);
> >-	retu_resource[0].start = gpio_to_irq(108);
> >-	platform_device_register(&retu_device);
> 
> hmmm, these three deleted lines look suspicious :-(
> 
> Let these cook for a while, I'll get back to them in a day or two. CBUS
> is making me crazy :-p

Marking these as changes needed then in pw.k.o.

Tony
