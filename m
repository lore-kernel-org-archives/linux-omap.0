From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Tue, 6 Jan 2015 14:47:33 +0200
Message-ID: <20150106124733.GE30544@fuloong-minipc.musicnaut.iki.fi>
References: <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
 <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
 <20150103000220.GE3279@atomide.com>
 <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
 <20150105154313.GA19336@saruman>
 <54ABC618.8070906@gmx.net>
 <20150106115250.GA27539@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:55003 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbbAFMrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 07:47:42 -0500
Content-Disposition: inline
In-Reply-To: <20150106115250.GA27539@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

Hi,

On Tue, Jan 06, 2015 at 12:52:50PM +0100, Sebastian Reichel wrote:
> On Tue, Jan 06, 2015 at 12:25:12PM +0100, Peter K=FCmmel wrote:
> > Am 05.01.2015 um 16:43 schrieb Felipe Balbi:
> > >Just booted AM335x with CONFIG_PREEMPT and haven't seen any proble=
m.
> > >Perhaps this is something related to another OMAP3-only driver?
> > >Perhaps HSI/SSI ?
> >=20
> > I see a ssi error directly before the IN-Band error:
> >=20
> > [    0.339935] platform 48058000.ssi-controller: Cannot lookup hwmo=
d 'ssi'
> > [    0.346893] In-band Error seen by MPU  at address 0
> > [    0.346923] ------------[ cut here ]------------
>=20
> mh I guess your board's dts included omap36xx.dtsi or omap34xx.dtsi.

This log occurs also on 3630, because ssi hwmod stuff is missing from
omap36xx_hwmod_ocp_ifs... Anyway, it's not related to this error, but n=
eed
to be added since we should get nokia-modem working also on N950/N9...

Peter: if you boot with "initcall_debug", you should see the error
is during the DMA setup.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
