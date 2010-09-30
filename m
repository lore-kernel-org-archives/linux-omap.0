From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [Beagleboard] linux-omap-pm -- cpufreq query
Date: Thu, 30 Sep 2010 06:48:00 -0700
Message-ID: <87hbh7l4vj.fsf@deeprootsystems.com>
References: <AANLkTim43rid4oGe2B8iTEXgVRMGT7=w6onNRF5zOQq=@mail.gmail.com>
	<AANLkTinBJGXBkhSRVeDX9upjwn_dMyECfSi5_rnmHhyt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43743 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab0I3NsF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 09:48:05 -0400
Received: by pwj5 with SMTP id 5so296765pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 06:48:05 -0700 (PDT)
In-Reply-To: <AANLkTinBJGXBkhSRVeDX9upjwn_dMyECfSi5_rnmHhyt@mail.gmail.com>
	(Haribabu Narayanan's message of "Wed, 29 Sep 2010 23:54:37 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Haribabu Narayanan <haribabu@iastate.edu>
Cc: linux-omap <linux-omap@vger.kernel.org>

Haribabu Narayanan <haribabu@iastate.edu> writes:

> =A0=A0 =A0Till recently I was working with Angstrom environment for
> beagleboard =A0(with a linux-omap-pm 2.6.29 kernel) and had to migrat=
e
> to the latest kernel version possible that is supported by
> linux-omap-pm branch for non-omap related reasons. =A0I am sticking t=
o
> linux-omap-pm instead of linux-omap or linux mainlines chiefly becaus=
e
> I need cpufreq related functionalities.
>
> =A0=A0I was happily using the latest head from linux-omap-pm when I
> realised that there are no frequency transitions that are=A0occurring
> now when I initiate requests through sys-fs writes. =A0I found out th=
at
> OMAP_PM_SRF is no longer supported (which was being used earlier on
> for helping with cpufreq changes).
>
> =A0=A0Is it that one cannot do cpufreq related changes with the
> current(+/-) linux-omap-pm kernel?=A0

That is correct.

> I checked linux-omap-pm's head/cpufreq branch for example and it
> contains only OMAP_PM_NONE and OMAP_PM_NOOP in plat-omap/Kconfig. Are
> there any=A0changes I can make so that I can get back cpufreq
> functionality.

The kernel parts that enable DVFS (including SmartReflex, voltage layer
etc.) are being rewritten and are under review and test currently.
The best way to help would be to contribute to that development and or
test these series from Thara.

> If yes, is there an general idea as to when this will
> be available with linux-omap-pm head ?

When it's ready. ;)

This is not a commitment, but I suspect we will have this into mainline
during the 2.6.38 merge window.

Kevin



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
