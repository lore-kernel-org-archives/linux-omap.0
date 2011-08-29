From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 3/4] omap: smps: add smps regulator init to voltage.c
Date: Mon, 29 Aug 2011 10:56:48 +0300
Message-ID: <1314604609.3699.5.camel@sokoban>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com> <1311853739-18984-4-git-send-email-t-kristo@ti.com> <8762mbph0f.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33139 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab1H2H46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 03:56:58 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T7uuXG032287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 02:56:56 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7T7uuRh009438
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 02:56:56 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <8762mbph0f.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

Sorry for bit late reply, I've been on holiday during last 3 weeks.

On Sat, 2011-08-06 at 01:37 +0200, Hilman, Kevin wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > All voltagedomains that have support for vc and vp are now automatically
> > registered with SMPS regulator driver. Voltage.c builds a platform device
> > structure for this purpose during late init.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> With the creation of this "dummy" platform device, I'm a bit confused
> about how is the mapping from device to regulator meant to work here.
> 
> e.g., for MPU DVFS, if I want to also scale voltage in the CPUfreq
> driver, I would do something like
> 
>         dev = omap2_get_mpuss_device()
> 
> and then want to somehow get the regulator associated with the MPU
> device so I can do a regulator_set_voltage().  What would I use for the
> id argument of regulator_get()?

Hmm right, I haven't been thinking about this part in too much detail.
However, the regulator names are built in following way:

- take voltdm name (e.g. mpu_iva)
- add "VDD_" in the beginning
- capitalize whole thing (results in VDD_MPU_IVA)

> What's missing (at least in my mind) is the mapping of devices to
> regulators.

True, should I think of something for this?

> 
> Specifically, this part doesn't seem right:
> 
> > +	supply->supply = "vcc";
> > +	supply->dev_name = voltdm->name;
> 
> becase voltdm->name is not a device name.
> 
> Kevin



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

