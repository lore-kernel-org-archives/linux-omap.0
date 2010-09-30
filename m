From: Haribabu Narayanan <haribabu@iastate.edu>
Subject: [Beagleboard] linux-omap-pm -- cpufreq query
Date: Wed, 29 Sep 2010 23:54:37 -0500
Message-ID: <AANLkTinBJGXBkhSRVeDX9upjwn_dMyECfSi5_rnmHhyt@mail.gmail.com>
References: <AANLkTim43rid4oGe2B8iTEXgVRMGT7=w6onNRF5zOQq=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45824 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab0I3Ey6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 00:54:58 -0400
Received: by iwn5 with SMTP id 5so1940207iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 21:54:57 -0700 (PDT)
In-Reply-To: <AANLkTim43rid4oGe2B8iTEXgVRMGT7=w6onNRF5zOQq=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,

=A0=A0 =A0Till recently I was working with Angstrom environment for
beagleboard =A0(with a linux-omap-pm 2.6.29 kernel) and had to migrate
to the latest kernel version possible that is supported by
linux-omap-pm branch for non-omap related reasons. =A0I am sticking to
linux-omap-pm instead of linux-omap or linux mainlines chiefly because
I need cpufreq related functionalities.

=A0=A0I was happily using the latest head from linux-omap-pm when I
realised that there are no frequency transitions that are=A0occurring
now when I initiate requests through sys-fs writes. =A0I found out that
OMAP_PM_SRF is no longer supported (which was being used earlier on
for helping with cpufreq changes).

=A0=A0Is it that one cannot do cpufreq related changes with the
current(+/-) linux-omap-pm kernel?=A0I checked linux-omap-pm's
head/cpufreq branch for example and it contains only OMAP_PM_NONE and
OMAP_PM_NOOP in plat-omap/Kconfig. Are there any=A0changes I can make s=
o
that I can get back cpufreq functionality. =A0If yes, is there an
general idea as to when this will be available with linux-omap-pm head
?

thx,
-hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
