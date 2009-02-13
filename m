From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 4/8] i2c: lp5521: move to LED framework
Date: Thu, 12 Feb 2009 18:00:55 -0600
Message-ID: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com>
References: <1234268165-23573-1-git-send-email-felipe.balbi@nokia.com> <1234268165-23573-4-git-send-email-felipe.balbi@nokia.com> <1234268165-23573-5-git-send-email-felipe.balbi@nokia.com> <200902121418.17837.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53528 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZBMABI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 19:01:08 -0500
In-Reply-To: <200902121418.17837.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org



On Thu, 12 Feb 2009 14:18:17 -0800, David Brownell <david-b@pacbell.net=
>
wrote:
> On Tuesday 10 February 2009, Felipe Balbi wrote:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip->ledr.name =3D "lp55=
21:red";
>=20
> Rule of thumb: assume there can always be multiple instances
> of a device.  In this case that's trivially possible
>=20
> Exception to that rule:  rare, based on system-wide concerns.
> Like there being only one PMIC, one OTG port, and so on.  In
> this case, not applicable.
>=20
>=20
> I'd suggest allocating some memory in the per-lp5521 struct
> to hold the strings, and catenating them with a label provided
> in the platform data.   That way you won't be assuming there's
> only a single lp5521, and the names for the LEDs can be more
> relevant to the board ... "n810::red" and so forth.

makes sense to me, I'll update this patch and resend :-)

--=20
Best Regards,

=46elipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
