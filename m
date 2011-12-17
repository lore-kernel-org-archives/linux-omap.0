From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Interesting L3 driver panic on v3.2-rc5 on 3530
Date: Sat, 17 Dec 2011 10:44:51 +0530
Message-ID: <CAMQu2gwVRd7XktK_oeg7pELwybFuc1MXUPrc8o8_TSDwJPJnZw@mail.gmail.com>
References: <alpine.DEB.2.00.1112161859190.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:41086 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750833Ab1LQFPO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 17 Dec 2011 00:15:14 -0500
Received: by qcsc2 with SMTP id c2so2399618qcs.7
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 21:15:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112161859190.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Sat, Dec 17, 2011 at 7:32 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi
>
> Just got this on a cold boot on 3530 BeagleBoard. =A0The hwmod warnin=
gs
> are expected, but the BUG() from the L3 bus driver ISR is not.
>
> Probably we should not BUG there, but log something akin to an x86
> machine check exception.
>
Looks like similar scenario as the DSS reset again and the timeout
error leading to BUG_ON.

May be we should not BUG_ON though that state of interconnect is
more or less not recoverable as per documents. That way at least boot
won't crash.

We need to find out the initiator leading to the timeout to see what's
going on.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
