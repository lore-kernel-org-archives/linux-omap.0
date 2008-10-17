From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 01/04] OMAP3 SRF: Generic shared resource f/w
Date: Fri, 17 Oct 2008 10:57:27 +0530
Message-ID: <029c01c93019$0c870260$LocalHost@wipultra1382>
References: <200810161127.41161.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43781 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYJQF1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 01:27:40 -0400
In-Reply-To: <200810161127.41161.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'David Brownell' <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]=20
> Sent: Thursday, October 16, 2008 11:58 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 01/04] OMAP3 SRF: Generic shared resource f/w
>=20
> On Thursday 16 October 2008, Rajendra Nayak wrote:
> > +=A0=A0=A0=A0=A0=A0=A0/* Function to change the level of the resour=
ce */
> > +=A0=A0=A0=A0=A0=A0=A0int (*change_level)(struct shared_resource *r=
es,=20
> u32 target_level);
> > +=A0=A0=A0=A0=A0=A0=A0/* Function to validate the requested level o=
f the=20
> resource */
> > +=A0=A0=A0=A0=A0=A0=A0int (*validate_level)(struct shared_resource =
*res,=20
> u32 target_level);
>=20
> What is a "target_level" supposed to represent?  Are they
> even comparable, in the senses that
>=20
>   (a) "42" for one resource is the same as "42" for another?
>   (b) "42" includes "41", "40", etc?
>=20
> There's no documentation at all on what seems to be a
> fairly fundamental concept.  Or on the rest of it either;
> the call syntax information is no real help.  What kind
> of "resource" is involved, that might need a "level"?

I'll try and put in some more details on the design. Whats essentially=20
planned is a framework to model "shared multi level" resources.
target_level and supported levels for each resource type might vary=20
and are platform specific and defined in the platform specific header f=
ile.
(In this case resource34xx.h file in mach-omap2)

Shared Multi level Resources currently planned to be modeled are Power-=
domain-latencies=20
(would have different latencies based on what state (RET/OFF) it enters=
=20
and hence multi level) and OPP/Frequency resources (Will have mutlitple=
 levels=20
each representing a defined OPP).

So for instance, for a VDD1-OPP resource a DSP load pridictor would req=
uest for OPP2
based on its predictions and CPUFreq might request OPP3 based on the AR=
M load.=20
The F/w then *sums* up all the requests and decides on whats the best *=
target_level*
for the resource which keeps everyone happy. =20
 =20
>=20
> Also, I suspect a flat namespace for all resources will
> be a net lose.  Why isn't it scoped by devices, so that
> device-relative "logical names" can be used instead of
> requiring what have tended to be platform-specific and
> very mutable "physical names"?  I notice that the call
> to request a resource is already device-scoped ...
>=20
> - Dave
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
