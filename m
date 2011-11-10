From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}
Date: Thu, 10 Nov 2011 09:37:18 -0800
Message-ID: <87ehxfg9pt.fsf@ti.com>
References: <1318851662-637-1-git-send-email-ohad@wizery.com>
	<CAK=WgbZ=h0OdeqLmNFwz31MN+o52-2ZNisFKgnJgwVLAyTTLCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:42294 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141Ab1KJRhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 12:37:23 -0500
Received: by mail-vx0-f180.google.com with SMTP id fo1so4076064vcb.39
        for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 09:37:22 -0800 (PST)
In-Reply-To: <CAK=WgbZ=h0OdeqLmNFwz31MN+o52-2ZNisFKgnJgwVLAyTTLCw@mail.gmail.com>
	(Ohad Ben-Cohen's message of "Wed, 9 Nov 2011 11:34:13 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Cousson Benoit <b-cousson@ti.com>

Ohad Ben-Cohen <ohad@wizery.com> writes:

> Hi Kevin,
>
> On Mon, Oct 17, 2011 at 1:41 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Expose omap_device_{alloc, delete, register} so we can use them outside
>> of omap_device.c.
>
> Can you please take this one ?

Yes, will queue for v3.3.

> Please tell me if you want a refreshed version against 3.2-rc1.

Current version is fine.

Kevin
