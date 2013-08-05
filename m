From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 4/4] ARM: OMAP2+: Sync hwmod state with the pm_runtime and omap_device state
Date: Mon, 05 Aug 2013 08:43:22 -0700
Message-ID: <87iozkkusl.fsf@linaro.org>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com>
	<1374487277-26099-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44466 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab3HEPn0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Aug 2013 11:43:26 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3506654pbb.5
        for <linux-omap@vger.kernel.org>; Mon, 05 Aug 2013 08:43:25 -0700 (PDT)
In-Reply-To: <1374487277-26099-5-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Mon, 22 Jul 2013 15:31:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, balbi@ti.com, mpfj-list@newflow.co.uk, vaibhav.bedia@ti.com, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, grygorii.strashko@ti.com

Rajendra Nayak <rnayak@ti.com> writes:

> Some hwmods which are marked with HWMOD_INIT_NO_IDLE are left in enabled
> state post setup(). When a omap_device gets created for such hwmods
> make sure the omap_device and pm_runtime states are also in sync for such
> hwmods by doing a omap_device_enable() and pm_runtime_set_active() for the
> device.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

This looks like the right fix to me.

Acked-by: Kevin Hilman <khilman@linaro.org>
