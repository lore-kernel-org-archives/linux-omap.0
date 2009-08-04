From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
	create twl6030 regulators
Date: Tue, 4 Aug 2009 18:54:21 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D8BD1708@dbde02.ent.ti.com>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com>
 <20090803142356.GA4265@rakim.wolfsonmicro.main>
 <20090804074544.GG24334@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44060 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518AbZHDNZD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 09:25:03 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "sameo@openedhand.com" <sameo@openedhand.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Nayak, Rajendra" <rnayak@ti.com>

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
Sent: Tuesday, August 04, 2009 1:27 PM
To: Tony Lindgren; Mark Brown
Cc: Krishnamoorthy, Balaji T; linux-omap@vger.kernel.org; khilman@deeprootsystems.com; david-b@pacbell.net; linux-i2c@vger.kernel.org; sameo@openedhand.com; wim@iguana.be; timo.t.kokkonen@nokia.com; ben-linux@fluff.org; lrg@slimlogic.co.uk; Nayak, Rajendra
Subject: RE: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to create twl6030 regulators

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, August 04, 2009 1:16 PM
> To: Mark Brown
> Cc: Krishnamoorthy, Balaji T; linux-omap@vger.kernel.org;
> khilman@deeprootsystems.com; david-b@pacbell.net; linux-
> i2c@vger.kernel.org; sameo@openedhand.com; wim@iguana.be;
> timo.t.kokkonen@nokia.com; ben-linux@fluff.org; lrg@slimlogic.co.uk; Nayak,
> Rajendra
> Subject: Re: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
> create twl6030 regulators
> 
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [090803 17:23]:
> > On Wed, Jul 29, 2009 at 10:06:13AM +0530, balajitk@ti.com wrote:
> >
> > > -	if (twl_has_regulator()) {
> > > +	if (twl_has_regulator() && is_class_twl4030()) {
> >
> > is_class_twl4030() feels like it should have better namespacing, though
> > having the part name in there means it's not actually an issue.
> 
> How about twl_is_4030()?
The idea was to have a class of twl4030 IC's type IC's. There are many of them with just different name (TPS *)
... twl_class_is_4030().... What you say ?

Can I suggest: pmic_class_is_xxx() ?

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

