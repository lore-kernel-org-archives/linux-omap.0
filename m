From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: State of LDP3430 platform
Date: Thu, 24 Feb 2011 12:38:44 +0530
Message-ID: <1fb43e4e01ba5d40aec63feb9acbfecb@mail.gmail.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20110212160216.GA22694@n2100.arm.linux.org.uk> <20110212161053.GA23481@n2100.arm.linux.org.uk>
 <20110223225022.GC30316@atomide.com> <13B9B4C6EF24D648824FF11BE896716203EFA5CDB2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41810 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932202Ab1BXHIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 02:08:48 -0500
Received: by fxm17 with SMTP id 17so295076fxm.11
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 23:08:46 -0800 (PST)
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203EFA5CDB2@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Woodruff, Richard
> Sent: Thursday, February 24, 2011 4:53 AM
> To: Tony Lindgren; Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Shilimkar, Santosh
> Subject: RE: State of LDP3430 platform
>
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, February 23, 2011 4:50 PM
>
> > Anybody from TI looking into these?
>
> I'll poke some folks and check.  I've not booted my LDP for a while.

There was a regulator mapping issue on 3430SDP because of
which tocuhscreen was broken and is now fixed with this patch
http://marc.info/?l=linux-arm-kernel&m=129673276608954&w=2
Looks like the same issue on LDP. Will check it up.

Regards,
Rajendra

>
> As an older 3430 dev board its lost its shine compared to 3630 and 4430
dev boards.
>
> Regards,
> Richard W.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
