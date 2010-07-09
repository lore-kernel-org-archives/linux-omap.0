From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 2/2] omap3: sr: improve errors handling
Date: Fri, 09 Jul 2010 18:50:35 +0300
Message-ID: <1278690635.9953.148.camel@localhost>
References: <1278681612-10521-1-git-send-email-dedekind1@gmail.com>
	 <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB032391F34E@dbde02.ent.ti.com>
	 <1278690245.9953.142.camel@localhost>  <4C374585.7030104@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40204 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184Ab0GIPyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 11:54:54 -0400
In-Reply-To: <4C374585.7030104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

On Fri, 2010-07-09 at 10:51 -0500, Nishanth Menon wrote:
> > So the logic is:
> >=20
> > 1. The subject line is a short description which gives the idea wha=
t the
> > commit is about. So, my subject line says:
> >   1.1. It is about omap3 (which is true)
> >   1.2. It is about sr (which is true)
> I think Thara's contention is that this is omap_device related- yeah =
SR=20
> is one of the users of omap_device, but there are much more folks usi=
ng=20
> omap_device in l-o today.

I see. I'll try to come up with a better prefix, but if you suggest me =
a
good subject line, I'll be grateful :-)

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
