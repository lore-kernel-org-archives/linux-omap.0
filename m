From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP2+: gpmc: Use irq_alloc_descs instead of
 static IRQ range
Date: Fri, 24 Feb 2012 11:55:15 +0530
Message-ID: <CAMQu2gwO=Kv5aPfrXuVOVMDA2P=S0SfR2ekMPT6o4MBTRsXHMQ@mail.gmail.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com> <1330035801-14937-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39259 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754435Ab2BXGZj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 01:25:39 -0500
Received: by qcsu28 with SMTP id u28so328767qcs.36
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 22:25:36 -0800 (PST)
In-Reply-To: <1330035801-14937-5-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> The gpmc code is still not a proper driver and is still using the bad=
 old
> static way of declaring its IRQ range for the various CS it can handl=
e (8).
>
> Use irq_alloc_descs to get dynamically a set of IRQ descriptors.
> Clean some bad line wrapping here and there.
>
> Please note that this code is still not a real driver after this fix,=
 and
> will require a massive cleanup...
>
Agree.

> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
> =A0arch/arm/mach-omap2/gpmc.c | =A0 22 +++++++++++++++-------
> =A01 files changed, 15 insertions(+), 7 deletions(-)
>
=46or the patch,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
