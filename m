From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] Fix OMAP4 boot regression
Date: Thu, 24 May 2012 15:23:57 +0530
Message-ID: <CANfBPZ9NrBurtTnyutqcRUg8f+GsRS3v8WHHwfPj6-npD1LUbw@mail.gmail.com>
References: <20120524090449.GA24486@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41237 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754082Ab2EXJyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 05:54:21 -0400
Received: by bkcjf20 with SMTP id jf20so10007929bkc.35
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 02:54:18 -0700 (PDT)
In-Reply-To: <20120524090449.GA24486@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, May 24, 2012 at 2:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Fix a boot regression in existing kernels causing:
>
> genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for i=
rq XXX
>
> caused by 1c6c6952 (genirq: Reject bogus threaded irq requests).
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-

Thanks Russell.
The omap_hsmmc part of the change was already posted [1] and queued up
in mmc-next.

Regards,
Venkat.

[1] http://www.spinics.net/lists/linux-omap/msg70496.html

> =A0drivers/rtc/rtc-twl.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A02 files changed, 2 insertions(+), 2 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
