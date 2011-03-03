From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 03/17] omap4: Export scu base address
Date: Thu, 3 Mar 2011 21:39:00 +0530
Message-ID: <98068b5a2cff38b99d47f8527340ce11@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-4-git-send-email-santosh.shilimkar@ti.com>
 <87lj0x6v70.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56781 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754035Ab1CCQJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:09:02 -0500
Received: by mail-qy0-f173.google.com with SMTP id 36so384qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:09:02 -0800 (PST)
In-reply-to: <87lj0x6v70.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 3:29 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 03/17] omap4: Export scu base address
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > The scu base address needs to be accessed in cpu hotplug
> > for power management. Hence export the same
>
> As with previous patch, rather than export the base address itself,
> it should export a helper function to get the base address
>

I dropped this patch in favor of the exported helpers to
get base address.
