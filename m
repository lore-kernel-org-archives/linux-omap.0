From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Thu, 19 Jul 2012 02:00:03 -0500
Message-ID: <CAOMWX4ccAJZur1ka89cboYZ8jsXHpvRiBoducgkU1CfdLX52ew@mail.gmail.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com> <1339428387-4800-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:58926 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178Ab2GSHA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 03:00:26 -0400
Received: by wibhm6 with SMTP id hm6so1756094wib.9
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 00:00:24 -0700 (PDT)
In-Reply-To: <1339428387-4800-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Minor nitpick:

On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
> +/**
> + * _omap4_get_context_lost - get context loss counter for a hwmod
Documentation missing for oh
btw, you might be interested in using http://www.omappedia.org/wiki/Kmake
to provide list of kerneldoc errors in addition to other easily
catchable errors..

> + *
> + * Returns the in-memory context loss counter for a hwmod.
> + */
> +static int _omap4_get_context_lost(struct omap_hwmod *oh)
> +{
> +       return oh->prcm.omap4.context_lost_counter;
> +}


Regards,
Nishanth Menon
