From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/5] omap: mailbox: initial hwmod support for omap3
Date: Tue, 09 Nov 2010 15:38:49 -0800
Message-ID: <87k4kmgj92.fsf@deeprootsystems.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
	<1288129984-22957-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41332 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0KIXix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 18:38:53 -0500
Received: by ywc21 with SMTP id 21so19413ywc.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 15:38:53 -0800 (PST)
In-Reply-To: <1288129984-22957-2-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Tue, 26 Oct 2010 16:53:00 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> HWMOD support for omap3.

-ENO_DESCRIPTIVE_CHANGELOG

Please describe in more detail what is happening here, starting with a
better subject:

       omap: mailbox: build device using omap_device/omap_hwmod

and the changelog should describe that what is being changed is that 
there is no longer a need for static platform_device and resources since
all of this data is contained in the omap_hwmod for the mailbox.


> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c              |  100 ++++-----------------------
>  arch/arm/mach-omap2/mailbox.c              |    1 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   54 +++++++++++++++

please separate out the addition of hwmod_data into it's own patch that
comes before this.  As mentioned by Charu, all the hwmod data could be
added early in the series, before this conversion is done.

Kevin
