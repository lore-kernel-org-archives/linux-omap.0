From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH fixes] [OMAP1] Add missing clocks for OMAP 7xx
Date: Mon, 21 Dec 2009 08:08:52 -0700
Message-ID: <6cb013310912210708s517f9ffcsa819cc358c5f9562@mail.gmail.com>
References: <1261326904-31656-1-git-send-email-darkstar6262@gmail.com>
	<alpine.DEB.2.00.0912201532500.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:49299 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZLUPJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 10:09:12 -0500
Received: by pwj9 with SMTP id 9so3209785pwj.21
        for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 07:09:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912201532500.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Sun, Dec 20, 2009 at 3:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Cory,
>
> Thanks, queued for .33-rcX. =C2=A0-- although I don't think this had =
anything
> to do with the clock_data.c conversion. =C2=A0At least,
>
> git diff 6f62b58dd4e697a23a308f5b77781394949d333e.. arch/arm/mach-oma=
p1/clock.c
>
> doesn't show a CK_7XX for either ck_dpll1 or api_ck in the original f=
ile.
>

Part of the purpose of that patch was to use the two clocks like every
other clock.  Prior to that, it was just assumed that that clock
existed for all devices, and it was used directly instead of calling
it out with a clock_get call or similar.  So, when the fix was made,
not having the CK_7XX meant those clocks weren't being used anymore
for omap 7xx devices, which broke things badly.

Thanks for queuing the change. :)

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
