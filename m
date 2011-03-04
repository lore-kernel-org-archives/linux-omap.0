From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Fri, 4 Mar 2011 11:41:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103041136280.10981@utopia.booyaka.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com> <4D67E0C0.4080805@ti.com> <alpine.DEB.2.00.1103031614440.10981@utopia.booyaka.com> <alpine.DEB.2.00.1103031652500.10981@utopia.booyaka.com> <4D70AF7A.90009@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-730888451-1299263849=:10981"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51757 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab1CDSlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 13:41:40 -0500
In-Reply-To: <4D70AF7A.90009@ti.com>
Content-ID: <alpine.DEB.2.00.1103041138440.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-730888451-1299263849=:10981
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1103041138441.10981@utopia.booyaka.com>

Hi Beno=EEt,

On Fri, 4 Mar 2011, Cousson, Benoit wrote:

> On 3/4/2011 12:53 AM, Paul Walmsley wrote:
> > On Thu, 3 Mar 2011, Paul Walmsley wrote:
> >=20
> > > On Fri, 25 Feb 2011, Cousson, Benoit wrote:
> > >=20
> > > >   static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] =3D {
> > > >   =09&omap3xxx_l3_main__l4_core,
> > > > -=09&omap3_l4_core__sr1,
> > > > -=09&omap3_l4_core__sr2,
> >=20
> > Never mind, I see the issue now...
>=20
> It was simply wrong as explained in the answer to Sanjeev.
> I do agree that the changelog does not say anything about it, sorry about
> that.
>=20
> BTW, do you want me to re-send that patch properly and not hidden in prev=
ious
> email thread with Sanjeev?

I guess the best thing to do would be to split that patch into two=20
patches: one which drops the bogus omap3xxx_l4_core_slaves entries, and=20
the other that removes the interconnect masters.  If you have the=20
opportunity, it might be good to extend the latter to 2420/2430 also.
Am not sure that getting rid of these is a good idea in the long run, but=
=20
am fine with doing it for now.


- Paul
--155748971-730888451-1299263849=:10981--
