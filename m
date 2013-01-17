From: Luciano Coelho <coelho@ti.com>
Subject: Re: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport
 power functions
Date: Thu, 17 Jan 2013 11:35:16 +0200
Message-ID: <1358415316.6252.20.camel@cumari.coelho.fi>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>
	 <50F7C4A7.5060202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42723 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129Ab3AQJgP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 04:36:15 -0500
In-Reply-To: <50F7C4A7.5060202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2013-01-17 at 10:30 +0100, Peter Ujfalusi wrote:
> Hi Luca,

Hi P=C3=A9ter!

> On 01/16/2013 10:45 PM, Luciano Coelho wrote:
> >  static struct ti_st_plat_data wilink_platform_data =3D {
> > -	.nshutdown_gpio	=3D 46,
> >  	.dev_name	=3D "/dev/ttyO1",
> >  	.flow_cntrl	=3D 1,
> >  	.baud_rate	=3D 3000000,
> > -	.chip_enable	=3D NULL,
> > -	.suspend	=3D NULL,
> > -	.resume		=3D NULL,
> > +	.chip_enable	=3D plat_kim_chip_enable,
> > +	.chip_disable	=3D plat_kim_chip_disable,
>=20
> I just wonder how this is going to work with DT... You are not going =
to have
> the ability to use callback in this form.
> I think the GPIO handling should be done in the driver itself rather =
than in
> the board file.

I agree.  The problem is that it used to be in the ti-st driver itself,
but it has been removed in a patch that says "different platforms have
begun to have their own ways to power-up/down the chip." (eccf2979
drivers/misc/ti-st: remove gpio handling).

This needs to be clarified first.  I think we could use this for now an=
d
later fix this properly (hopefully move it back to the ti-st driver).

--
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
