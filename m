From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: New build warnings
Date: Mon, 10 Sep 2012 07:33:34 +0800
Message-ID: <20120909233333.GA15911@opensource.wolfsonmicro.com>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk>
 <20120908083849.GA1603@n2100.arm.linux.org.uk>
 <20120909191240.GV28643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34648 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755812Ab2IIXdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Sep 2012 19:33:42 -0400
Content-Disposition: inline
In-Reply-To: <20120909191240.GV28643@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Arnd Bergmann <arnd@arndb.de>

On Sun, Sep 09, 2012 at 09:12:40PM +0200, Uwe Kleine-K=F6nig wrote:
> On Sat, Sep 08, 2012 at 09:38:49AM +0100, Russell King - ARM Linux wr=
ote:

> > >     of: add const to struct *of_device_id.data
> > >=20
> > >     Drivers should never need to modify the data of a device id. =
So it can
> > >     be const which in turn allows more consts in the driver.

> > I notice this one is still present in the kernel.  Uwe, what's happ=
ening
> > with it?

> Yeah, the warning was introduced by my patch. It's not trivial to fix
> because the twl-regulator driver modifies the data used to probe devi=
ces
> during probe. That is the result of two probes might depend on their
> order. I mentioned that problem in the cover letter of my series but =
got
> no feedback from someone feeling responsible for this driver.
> Arnd sent a patch for that problem, don't know its state though.

I don't recall such a patch being sent to me.  The twl-regulator driver
is unmaintained so it's unlikely anyone is going to actively work on it=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
