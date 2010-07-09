From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: RE: [PATCH 2/2] omap3: sr: improve errors handling
Date: Fri, 09 Jul 2010 18:44:05 +0300
Message-ID: <1278690245.9953.142.camel@localhost>
References: <1278681612-10521-1-git-send-email-dedekind1@gmail.com>
	 <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB032391F34E@dbde02.ent.ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39862 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757325Ab0GIPsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 11:48:19 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032391F34E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

On Fri, 2010-07-09 at 20:35 +0530, Gopinath, Thara wrote:
>=20
> >>-----Original Message-----
> >>From: Artem Bityutskiy [mailto:dedekind1@gmail.com]
> >>Sent: Friday, July 09, 2010 6:50 PM
> >>To: linux-omap@vger.kernel.org
> >>Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara; Peter p2 De Sch=
rijver
> >>Subject: [PATCH 2/2] omap3: sr: improve errors handling
> >>
> >>From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> >>
> >>Do not forget to check the 'platform_device_add_data()' error code
> >>in 'omap_device_build_ss()'.
>=20
> Hello Artem,
>=20
> Can we have a better subject and description. The subject esp has got
> nothing to do with the fix.

Hmm, I do not see why you think so. I think the subject is fine - the
patch improves error handling in the SR code. Then description says how
exactly it improves it - it makes the code to not forget to check the
return code, and it tells in which function and which return code.

So the logic is:

1. The subject line is a short description which gives the idea what th=
e
commit is about. So, my subject line says:
  1.1. It is about omap3 (which is true)
  1.2. It is about sr (which is true)
  1.3. It improves error handling (which is also true)

So the subject line is descriptive enough. It does not have to provide
all glory details.

Then the description provides the details.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
