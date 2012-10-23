From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Tue, 23 Oct 2012 09:51:19 +0200
Message-ID: <CAK=WgbZfJ3bg+Xt+HJtaiPHV=7=TK-=93SgB7cNp8XwwZRyB0Q@mail.gmail.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com> <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com> <20121016182642.GF15569@atomide.com>
 <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
 <507EA7DB.3070207@compulab.co.il> <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
 <20121019170759.GK4730@atomide.com> <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
 <5086494D.4080205@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40333 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab2JWHvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 03:51:40 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2758355iag.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 00:51:39 -0700 (PDT)
In-Reply-To: <5086494D.4080205@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

On Tue, Oct 23, 2012 at 9:37 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> +     ret = wl12xx_set_platform_data(wlan_data);
>> +     /* bail out silently in case wl12xx isn't configured */
>> +     if (ret == -ENOSYS)
>> +             return ret;
>
> Since we have the function ifdef'ed, I don't think we need
> the ENOSYS check, do we?

If we want to be strict, we better not remove it.

It's an interface that hides the internal implementation, and it's
just better not to assume anything beyond the return values and their
meanings. This way if WLAN folks change something in the future, we
don't need to update all the boards code again.

Thanks,
Ohad.
