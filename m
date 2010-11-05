From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] cbus: tahvo: move platform_device to board file
Date: Fri, 5 Nov 2010 09:40:20 -0700
Message-ID: <20101105164020.GK9264@atomide.com>
References: <1285936419-28426-1-git-send-email-balbi@ti.com>
 <1285936419-28426-4-git-send-email-balbi@ti.com>
 <20101001123737.GT2925@legolas.emea.dhcp.ti.com>
 <20101105163602.GJ9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64152 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab0KEQkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:40:35 -0400
Content-Disposition: inline
In-Reply-To: <20101105163602.GJ9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [101105 09:27]:
> * Felipe Balbi <balbi@ti.com> [101001 05:29]:
> > On Fri, Oct 01, 2010 at 07:33:38AM -0500, Balbi, Felipe wrote:
> > >@@ -255,9 +269,24 @@ static void __init n8x0_cbus_init(void)
> > >		return;
> > >	}
> > >
> > >-	set_irq_type(gpio_to_irq(108), IRQ_TYPE_EDGE_RISING);
> > >-	retu_resource[0].start = gpio_to_irq(108);
> > >-	platform_device_register(&retu_device);
> > 
> > hmmm, these three deleted lines look suspicious :-(
> > 
> > Let these cook for a while, I'll get back to them in a day or two. CBUS
> > is making me crazy :-p
> 
> Marking these as changes needed then in pw.k.o.

Ah already archived and looking at the later set now,
never mind..

Tony
