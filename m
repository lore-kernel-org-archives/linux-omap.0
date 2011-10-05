From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 12:48:49 -0700
Message-ID: <CAGDS+nng341_xQMAmQcu9J0avk0p1bbYC2vs53qTAc-DguoKZg@mail.gmail.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
	<877h4j5my0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45082 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233Ab1JETsu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 15:48:50 -0400
Received: by vws1 with SMTP id 1so1648428vws.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 12:48:49 -0700 (PDT)
In-Reply-To: <877h4j5my0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Dave Hylands <dhylands@gmail.com>, linux-omap@vger.kernel.org

On Wed, Oct 5, 2011 at 11:10 AM, Kevin Hilman <khilman@ti.com> wrote:

> The need to comment this out suggests that omap3_has_io_wakeup() is
> returning true for this SoC but should not.
>
> Looking at mach-omap2/io.c, that feature flag is not set on the 3505 =
and
> 3517, but is set on the 3503:
>
> =A0 =A0 =A0 =A0if (!cpu_is_omap3505() && !cpu_is_omap3517())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_features |=3D OMAP3_HAS_IO_WAKEUP=
;
>
> Adding a case for the 3503 here should fix this problem.
>
> Maybe check other checks for cpu_is_omap3505() and see if those shoul=
d
> also be checking for the 3503.

I only see this error on ES2.1 3503 based Overo COMs.

So I am wondering if there might be an errata in this area for early
3503 processors?

Do you have access to errata that you might check?  Or pointers to
publicly available errata that I could check?

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
