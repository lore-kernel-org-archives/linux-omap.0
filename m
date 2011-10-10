From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] ARM: OMAP: omap_device: Add omap_device_{alloc, delete, register}_ss
Date: Mon, 10 Oct 2011 09:37:08 +0200
Message-ID: <CAK=WgbbqG4qFAafJ49jdYwf19whxBGhtywTWVTnsejZ0F_ekog@mail.gmail.com>
References: <1317833693-21105-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41125 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab1JJHh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 03:37:29 -0400
Received: by wwf22 with SMTP id 22so8741185wwf.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 00:37:28 -0700 (PDT)
In-Reply-To: <1317833693-21105-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Kevin,

On Wed, Oct 5, 2011 at 6:54 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Split omap_device_build_ss() into two smaller functions:
...
> This patch is considered an interim solution until DT fully materializes
> for omap; at that point, this functionality will be removed.

Good news: we might not need this after all.

I need the remoteproc devices to exists at ->reserve() time, so I can
assign them a private CMA pool, which means I can't wait for
omap_device_build_ss() and must create the devices beforehand.

... which makes Benoit's alloc/delete methods perfect for me.

So please hold this one off for now. I'd just need a s/static// patch
that will allow me to use Benoit's methods outside of omap_device.c,
but I'll wait for things to settle down a bit before sending it, to
minimize this kind of churn.

Thanks and sorry for the noise,
Ohad.
