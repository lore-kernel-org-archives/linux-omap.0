From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/5] ARM: OMAP: irqs: Delete irqs-44xx.h file
Date: Fri, 24 Feb 2012 11:53:49 +0530
Message-ID: <CAMQu2gxhEuw_9Mr4_9LVwrOyaOE1oj6fc_pUG-RJ5KHcr1-c1A@mail.gmail.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com> <1330035801-14937-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:52768 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755004Ab2BXGYK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 01:24:10 -0500
Received: by qcsd16 with SMTP id d16so338495qcs.14
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 22:24:09 -0800 (PST)
In-Reply-To: <1330035801-14937-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> Since all IRQs should be retrieved using hwmod for the moment
> and then device tree in the future, there is no need to keep
> a file defining all the IRQ numbers.
>
> Delete the file and copy the 4 entries that are still used
> directly by the board / driver until the code is properly cleaned.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/irqs-44xx.h | =A0144 -------------=
--------------
> =A0arch/arm/plat-omap/include/plat/irqs.h =A0 =A0 =A0| =A0 15 +++-
> =A02 files changed, 12 insertions(+), 147 deletions(-)
> =A0delete mode 100644 arch/arm/plat-omap/include/plat/irqs-44xx.h
>
Nice. -144 :)
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
