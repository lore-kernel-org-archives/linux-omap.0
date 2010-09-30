From: Haribabu Narayanan <haribabu@iastate.edu>
Subject: Re: [Beagleboard] linux-omap-pm -- cpufreq query
Date: Thu, 30 Sep 2010 09:33:14 -0500
Message-ID: <AANLkTi=CbgCxrkGuOcSguSUnwwLbS+cAQx5-7Q_mszA+@mail.gmail.com>
References: <AANLkTim43rid4oGe2B8iTEXgVRMGT7=w6onNRF5zOQq=@mail.gmail.com>
 <AANLkTinBJGXBkhSRVeDX9upjwn_dMyECfSi5_rnmHhyt@mail.gmail.com> <87hbh7l4vj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41587 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407Ab0I3Odh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 10:33:37 -0400
Received: by yxp4 with SMTP id 4so803046yxp.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 07:33:36 -0700 (PDT)
In-Reply-To: <87hbh7l4vj.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Thanks Kevin.

Just to confirm, is there any version/branch beyond pm-2.6.34 that has
cpufreq functional for omap3?

-hari


On Thu, Sep 30, 2010 at 8:48 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Haribabu Narayanan <haribabu@iastate.edu> writes:
>
>> =A0=A0 =A0Till recently I was working with Angstrom environment for
>> beagleboard =A0(with a linux-omap-pm 2.6.29 kernel) and had to migra=
te
>> to the latest kernel version possible that is supported by
>> linux-omap-pm branch for non-omap related reasons. =A0I am sticking =
to
>> linux-omap-pm instead of linux-omap or linux mainlines chiefly becau=
se
>> I need cpufreq related functionalities.
>>
>> =A0=A0I was happily using the latest head from linux-omap-pm when I
>> realised that there are no frequency transitions that are=A0occurrin=
g
>> now when I initiate requests through sys-fs writes. =A0I found out t=
hat
>> OMAP_PM_SRF is no longer supported (which was being used earlier on
>> for helping with cpufreq changes).
>>
>> =A0=A0Is it that one cannot do cpufreq related changes with the
>> current(+/-) linux-omap-pm kernel?
>
> That is correct.
>
>> I checked linux-omap-pm's head/cpufreq branch for example and it
>> contains only OMAP_PM_NONE and OMAP_PM_NOOP in plat-omap/Kconfig. Ar=
e
>> there any=A0changes I can make so that I can get back cpufreq
>> functionality.
>
> The kernel parts that enable DVFS (including SmartReflex, voltage lay=
er
> etc.) are being rewritten and are under review and test currently.
> The best way to help would be to contribute to that development and o=
r
> test these series from Thara.
>
>> If yes, is there an general idea as to when this will
>> be available with linux-omap-pm head ?
>
> When it's ready. ;)
>
> This is not a commitment, but I suspect we will have this into mainli=
ne
> during the 2.6.38 merge window.
>
> Kevin
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
