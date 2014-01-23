From: Nishanth Menon <nm@ti.com>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Thu, 23 Jan 2014 11:33:50 -0600
Message-ID: <52E1527E.8020509@ti.com>
References: <52e06652.c103450a.79d7.6517@mx.google.com> <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com> <52E0B569.8000809@ti.com> <52E0CF58.5040109@epfl.ch> <52E0DA13.9090302@ti.com> <52E0DD9F.8000100@epfl.ch> <52E0E3D1.5050202@epfl.ch> <52E10AB4.9060002@ti.com> <52E144BC.4000900@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33271 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbaAWRd6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jan 2014 12:33:58 -0500
In-Reply-To: <52E144BC.4000900@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "tony@atomide.com" <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ash Charles <ash@gumstix.com>

On 01/23/2014 10:35 AM, Florian Vaussard wrote:
> 

[..]
> 
> Ok, so with your patch and changing the include from omap34xx to
> omap36xx, it works. Now I have to come up with a way to manage all the
> versions without duplicating all the DT files :-(

you'd also want to be careful about the omap3_pmx_core2 Vs
omap3_pmx_core2 split for padconf.

options that come to mind are:
a) split omap3-overo.dtsi into omap3-overo-common.dtsi
omap3-overo-34xx.dtsi,omap3-overo-36xx.dtsi, corresponding tobi board
dts file include as needed
b) only have common stuff in omap3-overo.dtsi, include omap34xx.dtsi
or omap36xx.dtsi in corresponding tobi board dts.

-- 
Regards,
Nishanth Menon
