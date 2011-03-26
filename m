From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Sat, 26 Mar 2011 17:01:38 +0530
Message-ID: <20110326113138.GA3668@avinash-laptop>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
 <20110314161609.GA10506@avinash-laptop>
 <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
 <4D8CA9C4.3060504@ti.com>
 <alpine.DEB.2.00.1103251121060.21987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57407 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751913Ab1CZLb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Mar 2011 07:31:59 -0400
Received: by mail-iw0-f175.google.com with SMTP id 10so2606530iwn.20
        for <linux-omap@vger.kernel.org>; Sat, 26 Mar 2011 04:31:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103251121060.21987@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On Fri, Mar 25, 2011 at 11:23:38AM -0600, Paul Walmsley wrote:
> Hi,
>=20
> On Fri, 25 Mar 2011, Cousson, Benoit wrote:
>=20
> > On 3/25/2011 6:38 AM, Paul Walmsley wrote:
> > > > > On Thu, 24 Feb 2011, Avinash.H.M wrote:
> > > > > > Some of the omap2, omap3 peripherals support software reset=
=2E This
> > > > > > can be done through the softreset bit in sysconfig register=
=2E
> > > > > > The reset status can be checked through resetdone bit of
> > > > > > sysstatus register. syss_has_reset_status is added to the h=
wmod
> > > > > > database of peripherals which have resetdone bit in sysstat=
us
> > > > > > register.
> > > > > >=20
> > > > > > Cc: Rajendra Nayak<rnayak@ti.com>
> > > > > > Cc: Paul Walmsley<paul@pwsan.com>
> > > > > > Cc: Benoit Cousson<b-cousson@ti.com>
> > > > > > Cc: Kevin Hilman<khilman@ti.com>
> > > > > > Reviewed-by: Govindraj.R<govindraj.raja@ti.com>
> > > > > > Signed-off-by: Avinash.H.M<avinashhm@ti.com>
> > >=20
> > > This patch is causing I2C softreset timeouts in the hwmod layer o=
n OMAP2
> > > and 3.  Could you please take a look at this and figure out what =
is going
> > > on?
> >=20
> > I think this is probably due to the nasty I2C softreset bug with di=
scussed
> > last year with Paul Brady.
> >=20
> > AFAIR, the I2C cannot be reset by just writing to the SYSCONFIG sof=
treset bit.
> > You need to play with other registers too.

Thanks Benoit. You are right.=20

The TRM Section '18.3.1.3.2 Software Reset' explains the steps for
softresetting I2C. The steps are below:

1. Ensure that the module is disabled (clear the I2Ci.I2C_CON[15] I2C_E=
N
bit to 0).
2. Set the I2Ci.I2C_SYSC[1] SRST bit to 1.
3. Enable the module by setting I2Ci.I2C_CON[15] I2C_EN bit to 1.
4. Check the I2Ci.I2C_SYSS[0] RDONE bit until it is set to 1 to indicat=
e
the software reset is complete.

>=20
> Thanks Beno=EEt.
>=20
> So then, Avinash, you might need to create a custom hwmod class=20
> reset function for the I2C block (viz., struct omap_hwmod_class.reset=
)

OK Paul. I'll add the I2C_CON register and follow the above sequence as
suggested in the TRM in the custom I2C reset function.

br,

- Avinash

>=20
> > Avinash,
> > You should try to look at 3430 or 3630 errata. You will probably fi=
nd the bug
> > I'm referring to.
>=20
>=20
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
