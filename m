From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
Date: Wed, 7 Apr 2010 08:02:03 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C43ADE81@dbde02.ent.ti.com>
References: <1269268704-31347-1-git-send-email-charu@ti.com>,<87mxxgi49c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0DGCgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 22:36:52 -0400
In-Reply-To: <87mxxgi49c.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

________________________________________
> From: Kevin Hilman [khilman@deeprootsystems.com]
> Sent: Wednesday, April 07, 2010 4:21 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
> 
> Charulatha V <charu@ti.com> writes:
> 
> > Access to some of the OMAP4 GPIO registers are not properly handled.
> > This patch fixes it.
> >
> 
> Tested on... ?

Tested on 3430SDP and 4430SDP.

> > Signed-off-by: Charulatha V <charu@ti.com>
> ---

[...]

> > @@ -1570,9 +1603,14 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
> >               reg += OMAP7XX_GPIO_DIR_CONTROL;
> >               break;
> >       case METHOD_GPIO_24XX:
> > -     case METHOD_GPIO_44XX:
> >               reg += OMAP24XX_GPIO_OE;
> >               break;
> > +     case METHOD_GPIO_44XX:
> > +             reg += OMAP4_GPIO_OE;
> > +             break;
> > +     default:
> > +             WARN_ON(1);
> > +             return -EINVAL;
> 
> If you add a WARN, please add a helpful string.

Added this WARN in the same way as in other functions 
of the same file.

> 
> Otherwise, this looks OK to me.
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks.