From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Fri, 16 Jan 2009 13:27:52 -0800
Message-ID: <200901161327.52661.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <20090116073736.GO4128@atomide.com> <20090116153523.GD32481@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:46416 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1764465AbZAPV1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 16:27:54 -0500
In-Reply-To: <20090116153523.GD32481@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 16 January 2009, Felipe Balbi wrote:
> 
> I think it's time to send this via greg so we can get musb working on
> beagle. No otg though due to missing CONFIG_PM for omap3. Any plans to
> get that upstream ??

So why not just enable PM=y in the configuration?  It's not
actually required to do much, beyond not being broken.

- Dave

