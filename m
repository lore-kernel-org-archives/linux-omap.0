From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 1 Apr 2011 20:12:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com> <1301489930.15095.51.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-632197865-1301709738=:27897"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54947 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab1DBCM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 22:12:59 -0400
In-Reply-To: <1301489930.15095.51.camel@deskari>
Content-ID: <alpine.DEB.2.00.1104012003370.27897@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-632197865-1301709738=:27897
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1104012003371.27897@utopia.booyaka.com>

Hi Tomi, Beno=EEt, et al,

On Wed, 30 Mar 2011, Tomi Valkeinen wrote:

> Currently we have these aliases for OMAP4:
>=20
> "dss_clk" -> dss_dss_clk
> "fck" -> dss_fck
> "ick" -> dummy_ck
>
> If that would be changed to:
>
> "fck" -> dss_dss_clk
> "ick -> dss_fck
>
> The driver would work the same way for all OMAPs.

This looks reasonable to me, and seems to match the TRM's Figure 10-4 "DSS=
=20
Clock Tree".

The current OMAP4 clock data name "dss_fck" is just kind of a fake name=20
for that clock in the OMAP4 context.

> Anyway. To get things working for rc2 (DSS currently crashes due to not
> enabling dss_clk) we need to either:
> 1) Change the clock aliases as above
> 2) Add something like Sumit's patch (attached) to handle dss_clk. While
> the patch is not that complex, it feels rather hacky.

Yeah, that patch looks like a hack to me, especially something like=20
this:

+       if (pdata->opt_clock_available("dss_clk")) {

Based on the E-mail thread so far, I'd say that changing the clock aliases=
=20
is the way to go for right now.  The clock aliases are not hardware data;=
=20
they just control how the clock hardware is mapped to the drivers.

Of course, at some point soon, those clock aliases are going to go away. =
=20
But hopefully you all will have converted the driver over to PM runtime at=
=20
that point.

Once that happens, there's another problem: omap_hwmod_enable() is defined=
=20
that the hardware registers should be accessible by the MPU after it=20
completes.  So by that definition, the hwmod code should be=20
enabling/disabling that dss_clk clock too when it enables/idles/shuts down=
=20
the hwmod.  Probably we'd need to mark that struct omap_hwmod_opt_clk with=
=20
some flag.  Then we'd need some kind of way for the DSS to tell the hwmod=
=20
code whether it is or isn't reliant on the PRCM-provided functional clock=
=20
for its internal functional clock.  Maybe something like=20
omap_hwmod_{release,require}_system_fclk()?


- Paul
--155748971-632197865-1301709738=:27897--
