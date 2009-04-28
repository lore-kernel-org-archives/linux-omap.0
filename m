From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [RFC] [Patch 0/2] Proposal for changes to TWL4030/TWL5030
 framework for integrating the new TWL6030 chip
Date: Tue, 28 Apr 2009 16:25:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030548B2AF@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B42BDE9B@dbde02.ent.ti.com>
 <20090428084013.GA3909@scadufax.research.nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B42BE0EB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60665 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbZD1Kzf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 06:55:35 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B42BE0EB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Jagadeesh,

We are also working on similar lines and I have already sent a RFC to 
discuss it further in the community. Please have a look at the below 
link and provide your comments:

http://marc.info/?l=linux-omap&m=124083364321017&w=2

Regards,
Anuj Aggarwal

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pakaravoor, Jagadeesh
> Sent: Tuesday, April 28, 2009 2:42 PM
> To: felipe.balbi@nokia.com
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [RFC] [Patch 0/2] Proposal for changes to TWL4030/TWL5030
> framework for integrating the new TWL6030 chip
> 
> > -       if (twl_has_keypad() && pdata->keypad) {
> > +       if (twl_has_keypad() && pdata->keypad &&
> > +                       !(features & TLW6030)) {
> >                 child = add_child(2, "twl4030_keypad",
> >                                 pdata->keypad, sizeof(*pdata->keypad),
> >                                 true, pdata->irq_base + 1, 0);
> >
> > You'd probably only need to make changes to register defines but almost
> > everything else could remain as is. There shouldn't be any need for
> > creating separate files.
> >
> Patch 0, of the series explains the differences between TWL4030 and TWL6030.
> 
> Going the aforesaid way, we will need checks like this in almost every other
> line of code. And I believe having a separate file would be more modular, and
> hence readable (a twl.c which will bind with twl4030-core.c and twl4030-irq.c if
> TWL4030 is selected, and twl6030-core.c and twl6030-irq.c if TWL6030 is
> selected).
> 
> I am not sure how we can incorporate all the hardware changes by just
> changing register addresses.
> 
> --
> Jagadeesh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

