From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] ARM: OMAP3: fix build on !CONFIG_IOMMU_API
Date: Fri, 13 Jan 2012 17:54:10 +0200
Message-ID: <CAK=WgbZH_aZ44Crvy9dVHgXAAbeG=LkjetFg-7RAp+iJ4m7dQg@mail.gmail.com>
References: <1326288491-25146-1-git-send-email-ohad@wizery.com> <20120113110728.GC2275@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63742 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222Ab2AMPyb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 10:54:31 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so4517614iab.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 07:54:31 -0800 (PST)
In-Reply-To: <20120113110728.GC2275@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Arik Nemtsov <arik@wizery.com>, Raja Govindraj <govindraj.raja@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Fri, Jan 13, 2012 at 1:07 PM, Joerg Roedel <Joerg.Roedel@amd.com> wrote:
> Will apply it as soon as the merge window closes.

Thanks.

Though we might want to consider sending this to Linus before rc1, to
eliminate global developers' pain as much as possible :)
