From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v2 1/2] ARM: dts: add dtsi for palmas
Date: Mon, 10 Jun 2013 09:24:57 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EAB45@DBDE04.ent.ti.com>
References: <1370855059-5342-1-git-send-email-j-keerthy@ti.com>
 <1370855059-5342-2-git-send-email-j-keerthy@ti.com>
 <51B59B81.8040208@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab3FJJZU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 05:25:20 -0400
In-Reply-To: <51B59B81.8040208@nvidia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, "lee.jones@linaro.org" <lee.jones@linaro.org>

Hi Laxman,

> -----Original Message-----
> From: Laxman Dewangan [mailto:ldewangan@nvidia.com]
> Sent: Monday, June 10, 2013 2:55 PM
> To: J, KEERTHY
> Cc: Cousson, Benoit; devicetree-discuss@lists.ozlabs.org; linux-
> omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> grant.likely@secretlab.ca; swarren@wwwdotorg.org; Stephen Warren;
> sameo@linux.intel.com; gg@slimlogic.co.uk; lee.jones@linaro.org
> Subject: Re: [PATCH v2 1/2] ARM: dts: add dtsi for palmas
> 
> On Monday 10 June 2013 02:34 PM, J Keerthy wrote:
> > Adds palmas mfd and palmas regulator nodes.
> >
> > Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > ---
> >   arch/arm/boot/dts/palmas.dtsi |   98
> +++++++++++++++++++++++++++++++++++++++++
> 
> Hi Keerthy,
> Can you please add documentation for dt binding:
> Documentation/devicetree/bindings/mfd
> 

https://lkml.org/lkml/2013/6/6/25

It is based on this.

> Most of time we refer from this document for dt population.
> 
> Thanks,
> Laxman
