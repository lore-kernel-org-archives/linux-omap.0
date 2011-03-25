From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Fri, 25 Mar 2011 11:23:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103251121060.21987@utopia.booyaka.com>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com> <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com> <20110314161609.GA10506@avinash-laptop> <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com> <4D8CA9C4.3060504@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1728999152-1301073818=:21987"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42403 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1CYRXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 13:23:40 -0400
In-Reply-To: <4D8CA9C4.3060504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Mahadeva, Avinash" <avinashhm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1728999152-1301073818=:21987
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 25 Mar 2011, Cousson, Benoit wrote:

> On 3/25/2011 6:38 AM, Paul Walmsley wrote:
> > > > On Thu, 24 Feb 2011, Avinash.H.M wrote:
> > > > > Some of the omap2, omap3 peripherals support software reset. This
> > > > > can be done through the softreset bit in sysconfig register.
> > > > > The reset status can be checked through resetdone bit of
> > > > > sysstatus register. syss_has_reset_status is added to the hwmod
> > > > > database of peripherals which have resetdone bit in sysstatus
> > > > > register.
> > > > >=20
> > > > > Cc: Rajendra Nayak<rnayak@ti.com>
> > > > > Cc: Paul Walmsley<paul@pwsan.com>
> > > > > Cc: Benoit Cousson<b-cousson@ti.com>
> > > > > Cc: Kevin Hilman<khilman@ti.com>
> > > > > Reviewed-by: Govindraj.R<govindraj.raja@ti.com>
> > > > > Signed-off-by: Avinash.H.M<avinashhm@ti.com>
> >=20
> > This patch is causing I2C softreset timeouts in the hwmod layer on OMAP=
2
> > and 3.  Could you please take a look at this and figure out what is goi=
ng
> > on?
>=20
> I think this is probably due to the nasty I2C softreset bug with discusse=
d
> last year with Paul Brady.
>=20
> AFAIR, the I2C cannot be reset by just writing to the SYSCONFIG softreset=
 bit.
> You need to play with other registers too.

Thanks Beno=EEt.

So then, Avinash, you might need to create a custom hwmod class=20
reset function for the I2C block (viz., struct omap_hwmod_class.reset)

> Avinash,
> You should try to look at 3430 or 3630 errata. You will probably find the=
 bug
> I'm referring to.


- Paul
--155748971-1728999152-1301073818=:21987--
