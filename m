From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 11/17] omap4: suspend: Add MPUSS RET and OFF support
Date: Thu, 3 Mar 2011 22:01:51 +0530
Message-ID: <cbac34d988ad1a47e3b8d4e557a28130@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-12-git-send-email-santosh.shilimkar@ti.com>
 <87r5ap2lbg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60378 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754587Ab1CCQbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:31:53 -0500
Received: by mail-qw0-f52.google.com with SMTP id 6so1159034qwf.11
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:31:52 -0800 (PST)
In-reply-to: <87r5ap2lbg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 4:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 11/17] omap4: suspend: Add MPUSS RET and OFF
> support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>

[...]
> > +
> > +	/* Set targeted power domain states by suspend */
> > +	list_for_each_entry(pwrst, &pwrst_list, node) {
> > +		/* FIXME: Remove this check when CORE retention is
> supported */
> > +		if (!strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
> > +			omap_set_pwrdm_state(pwrst->pwrdm, pwrst-
> >next_state);
> > +	}
>
> pwrst_list is the list of powerdomains to that will be changed
> during suspend.
>
> Rather than doing this string match for every suspend, just do the
> check once during init and only add powerdomains that can
> transition to the list.
>
Will fix this accordingly then.
