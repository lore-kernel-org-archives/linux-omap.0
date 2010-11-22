From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 18:05:55 +0530
Message-ID: <baa166f04ffdef2ae7003165b13a0b2c@mail.gmail.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com><21f7524db02d0a4c2a9f71587937d200@mail.gmail.com>
 <AANLkTikUkA=Uwd+UGStdiuV_LCBLZaKo4KRp2bj_UwH3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50711 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755014Ab0KVMf7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 07:35:59 -0500
Received: by mail-qy0-f176.google.com with SMTP id 10so149110qyk.0
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 04:35:59 -0800 (PST)
In-Reply-To: <AANLkTikUkA=Uwd+UGStdiuV_LCBLZaKo4KRp2bj_UwH3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Monday, November 22, 2010 5:01 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID; Kevin Hilman
> Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
>
> On Mon, Nov 22, 2010 at 11:53 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jean Pihet
> >> Sent: Monday, November 22, 2010 4:15 PM
> >> To: linux-omap@vger.kernel.org
> >> Cc: Jean Pihet; Kevin Hilman
> >> Subject: [PATCH] OMAP3: disable idle early in the suspend sequence
> >>
> >> Some bad interaction between the idle and the suspend paths has been
> >> noticed: the idle code is called during the suspend enter and exit
> >> sequences. This could cause corruption or lock-up of resources.
> >
> > Can you elaborate more on what kind of issues were seen?
>
> Trying to get the PRCM registers dump after a suspend/resume does not
> show the correct registers values, cf. Kevin's patch at
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
> pm.git;a=commitdiff;h=9fc4891d4a21d2b644a463d62c77ef97da55f091.
>
> Digging a bit further I found out that the idle routine is called >50
> times while the suspend/resume sequence still is on-going. The root
> cause is because disable_hlt is called from omap3_pm_prepare which
> runs after omap3_pm_begin (and the same issue in the resume sequence).
> This leaves a time window for idle to kick-in while the suspend
> sequence is busy saving/restoring the system state. This is a
> potential bug that just waits to show up soon or later, especially if
> more code is added in the suspend prepare and finish functions.

Ok. Thanks. Basically we had some similar issues on OMAP4. I am yet to
root
cause, but the initial hunch was there was a race between idle and suspend
and I did pretty much the same change in pm44xx.c.
That fixed the issue but only partially, so am still in the process of
debugging
it further to see what exactly is the issue. So was just curious to know
what
issues you ran into on OMAP3.
Will update once I know whats happening on OMAP4.

>
> Does the changelog need an update?

No, The changelog looks fine to me.

Thanks,
Rajendra

>
> Regards,
> Jean
