From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
Date: Fri, 24 Feb 2012 14:01:10 +0000
Message-ID: <20120224140109.GG5450@opensource.wolfsonmicro.com>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
 <20120224132408.GF5450@opensource.wolfsonmicro.com>
 <1330091765.4102.547.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42724 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756693Ab2BXOBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 09:01:12 -0500
Content-Disposition: inline
In-Reply-To: <1330091765.4102.547.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 03:56:05PM +0200, Tero Kristo wrote:

> So, do you want me to also change the num_voltages value for the
> regulator from zero to be the same as max_uV, as we have this check
> within regulator/core:

>        if (!ops->list_voltage || selector >= rdev->desc->n_voltages)
>                 return -EINVAL;

> This will also potentially make some code to iterate over regulator
> voltages for ~1.5M times. I still don't think adding list_voltage for
> the SMPS regulators makes any sense, unless either the API for
> regulator_list_voltage is changed, or we change the control for these
> regulators completely from set_voltage() based to set_voltage_sel()
> based implementation.

Well, the important thing here is to fill in something useful for the
returned selector rather than just leaving it undefined.  Providing a
list_voltage() would be nice and make things more robust.

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR5gfAAoJEBus8iNuMP3dn9MP/0Bv2BXCDGcZTVM1Q+Df2V/m
cvExl1v/42e9PbnkhNeBjNyEN64x7OgAkgl4HcxDfMWGmHCv4dbgR/yIDpsYZSCt
HkvuwiMzJsZtMKP/Pw2aAQBh3U6vsqB0nY+Sd+c/vZ26mZw22saY7PFw1dmdtjbp
2gF57igouQYPJDZFwxyrMnPC6Y0PacIumfsG90LAk7JhgRrD3qQfw2kQhje3kCLf
kWgXvYLDC7a5MlS2REpoh4yn3NILrWwS3UeTbWur/5f4+1oN8RBvEqotj6ozRmgY
Aa3EWKgu9yhd1e92pgdrQfxi3ObWYTD3DTam8X5RuuBbodY87RKLzkOcc0ug1XmL
8/DpEKVmkletrZntohjA/UaJ0LoSGKurWJ0x0C+h0Y6XeozUblF2040jXyBJRzsG
DURb2BQwlayrkBjA5bRe+7XWDG8RkpeXdiG59Ab/2bsvvQ2aKfZK+MwGwaANUEYC
EtVyMU/L5mtLorztLOG80utG000s+DXiRu4Du00hQoixaabE12uUdH5XDRFeYKkr
ZBUaa9ScICXKHn3jn3xZGw14cHJu275jdNPBKl8N34LX2MKR/vRg5oZUIEAakmxR
ZzE5k3863xJ0Y3Zqo7m/9qvDxvMRTLCc2Ds+5zgQk/y3bzn/kg0WfY1Tts3BkUxf
knx0pi2Fdr7ITzkZU8ud
=rOjb
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
