From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP2+: Fix Compilation error on current mainline
Date: Tue, 8 Nov 2011 12:03:48 +0530
Message-ID: <CAMQu2gw0BUZq0gVf4Xq2D-T0LAO7Q7T3mtdjQHQ0Z59xBbgnMg@mail.gmail.com>
References: <4EB7E50D.40406@ti.com> <1320733698-23411-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42015 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717Ab1KHGeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 01:34:10 -0500
Received: by mail-qw0-f47.google.com with SMTP id j40so52484qab.20
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 22:34:09 -0800 (PST)
In-Reply-To: <1320733698-23411-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>

On Tue, Nov 8, 2011 at 11:58 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
> Patch to fix below compilation error on latest mainline commit
> b32fc0a0629bf5894b35f33554c118aacfd0d1e2 with omap2plus_defconfig.
>
> arch/arm/mach-omap2/omap_l3_noc.c:250: error: 'THIS_MODULE' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/omap_l3_noc.o] Error 1
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
