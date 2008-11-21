From: "Misael Lopez" <mesak82@gmail.com>
Subject: Re: [PATCH][OMAPZOOM] OMAP3: Fix handling of McBSP registers XCCR and RCCR for OMAP2430/34xx
Date: Fri, 21 Nov 2008 00:25:23 -0600
Message-ID: <76fbac300811202225m53237b1cq7dde99d5ace9a62a@mail.gmail.com>
References: <1227241883-26009-1-git-send-email-mesak82@gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02E22882D0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:57270 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYKUGZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 01:25:25 -0500
Received: by fg-out-1718.google.com with SMTP id 19so624243fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 22:25:23 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E22882D0@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

> > @@ -403,8 +408,10 @@ struct omap_mcbsp_reg_cfg {
> >  	u16 rcerh;
> >  	u16 xcerg;
> >  	u16 xcerh;
> > +#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
> >  	u16 xccr;
> >  	u16 rccr;
> > +#endif
> >  };
>
> Won't this cause a compilation break on non-2430/34xx platforms
> because you refer to these variables below?
True... I didn't consider that. Then for non-2430/34xx platforms,
having those registers in the structure but avoiding to write to them
is enough, correct? or any other alternative?
