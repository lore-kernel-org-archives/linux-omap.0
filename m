From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Wed, 4 Jul 2012 13:02:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207041259400.6760@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk>  <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>  <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>  <4FDA45F5.9090300@ti.com>  <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
  <4FDB387C.7030003@ti.com>  <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>  <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>  <87mx3f38lh.fsf@ti.com>  <4FF46BF5.50308@ti.com> <1341420070.2059.185.camel@sokoban> <4FF472C9.6000107@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-539376531-1341428538=:6760"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60195 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab2GDTCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 15:02:19 -0400
In-Reply-To: <4FF472C9.6000107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: t-kristo@ti.com, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-539376531-1341428538=:6760
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Jul 2012, Benoit Cousson wrote:

> On 07/04/2012 06:41 PM, Tero Kristo wrote:
> > On Wed, 2012-07-04 at 18:14 +0200, Benoit Cousson wrote:
> >>
> >> On OMAP4 as well? I've just tried with the hwmod fix for AESS and USB
> >> and still cannot reach RET.
> >>
> >> Am I missing some other patches for OMAP4?
> >=20
> > You need also fixes for sl2if and mcpdm in addition to above.
>=20
> Are they in some lo branch already?

The old version of these patches are in the 'sl2if_mcpdm_reset_fix_3.5rc`=
=20
branch of git://git.pwsan.com/linux-2.6 - they haven't yet been updated=20
and tested per Beno=C3=AEt's comments.  If someone else wants to take that =
over=20
for 3.5-rc, by all means please do.


- Paul
--155748971-539376531-1341428538=:6760--
