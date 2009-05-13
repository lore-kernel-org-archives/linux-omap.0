From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESOLVED] Please help creating gpio-switch on ams-delta
Date: Wed, 13 May 2009 14:41:43 +0200
Message-ID: <4A0AC007.4040704@tis.icnet.pl>
References: <4A09552F.5090402@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:45949 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757166AbZEMMmI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2009 08:42:08 -0400
In-Reply-To: <4A09552F.5090402@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: e3-hacking@earth.li

Janusz Krzysztofik napisa=B3(a):
> I have tried two methods: gpio-switch and gpio-keys. gpio-switch devi=
ce=20
> is able to report the switch initial state correctly, gpio-keys devic=
e=20
> just initializes without errors. However, for both methods, after fir=
st=20
> switch change, the system stops responding, giving no error messages.
>=20
> The code of goip-switch initialization sequence together with my=20
> platform device definition (attached) does not look any different to =
me=20
> than those for keyboard or modem (patches available from=20
> http://the.earth.li/pub/e3/2.6.19/), that both also use GPIO interrup=
ts=20
> and do work for me.

Hi,

I have found that one of the patches, keyboard or modem, from=20
http://the.earth.li/pub/e3/2.6.19, break gpio interrupt handling (as=20
Jonathan McDowell said*, he found it conflicted with the FIQ keyboard=20
patch). Without them, both gpio-switch and gpio-keys versions of a=20
platform device for ams-delta hook switch do work for me. I can try to=20
provide patches against omap git tree if there is any interest.

Thanks,
Janusz

* http://www.earth.li/pipermail/e3-hacking/2009-May/000868.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
