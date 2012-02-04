From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC 1/1] omap3: PM: MPU and CORE should stay awake if there
 is CAM domain ACTIVE
Date: Sat, 04 Feb 2012 14:11:28 +0200
Message-ID: <4F2D2070.8060701@iki.fi>
References: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi> <alpine.DEB.2.00.1202011458490.10541@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:60793 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab2BDMLu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 4 Feb 2012 07:11:50 -0500
In-Reply-To: <alpine.DEB.2.00.1202011458490.10541@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com, khilman@ti.com

Paul Walmsley wrote:
> On Fri, 27 Jan 2012, Sakari Ailus wrote:
>=20
>> MPU and CORE should stay awake if there is CAM domain ACTIVE.
>=20
> I guess this should read that MPU and CORE should stay awake if the I=
SP IP=20
> block is active?
>=20
>> This is because that module doesn't have wake-up capability.
>>
>> The original patch was written by Jouni H=F6gander in 2008 and this =
is the
>> last part left of it which is not in upstream yet.
>>
>> I wonder if the approach taken in the patch is valid these days;
>> nevertheless it seems to do the job...
>=20
> Unfortunately we do not yet have a Linux generic framework for this s=
ort=20
> of thing yet, and Tony doesn't want to add more platform_data functio=
n=20
> pointers.  So in the interim, would suggest following an=20
> approach similar to the patch at the bottom of this message:
>=20
> http://www.spinics.net/lists/linux-omap/msg63495.html
>=20
> using PM QoS constraints to get what you want.  Make sure you keep th=
e big=20
> nasty comment in there.  That way, when someone manages to get some=20
> generic support in for it, we can convert it over easily.
>=20
> We should probably be marking all of these IP blocks with broken wake=
up=20
> with a hwmod flag also, for warning purposes if nothing else.  "Warni=
ng,=20
> missing IP block wakeup line; energy consumption will be higher than=20
> necessary; please annoy your silicon vendor"

Thanks Kevin, Paul and Jean!

I think we'll then make a similar change to the ISP driver until the
matter is resolved in a generic way.

Regards,

--=20
Sakari Ailus
sakari.ailus@iki.fi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
