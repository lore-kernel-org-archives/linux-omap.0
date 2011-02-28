From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 10/13] OMAP3: Add voltage dependency table for VDD1.
Date: Mon, 28 Feb 2011 13:48:44 +0200
Message-ID: <20110228134844.cbc807b2.jhnikula@gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-11-git-send-email-vishwanath.bs@ti.com>
	<87hbcsblet.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56396 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab1B1Lrf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 06:47:35 -0500
Received: by ewy6 with SMTP id 6so1250179ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 03:47:34 -0800 (PST)
In-Reply-To: <87hbcsblet.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

On Fri, 28 Jan 2011 16:31:22 -0800
Kevin Hilman <khilman@ti.com> wrote:

> Hi Vishwa,
> 
> Vishwanath BS <vishwanath.bs@ti.com> writes:
> 
> > +/* OMAP 3430 MPU Core VDD dependency table */
> > +static struct omap_vdd_dep_volt omap34xx_vdd1_vdd2_data[] = {
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP1_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP50_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP2_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP50_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP3_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP4_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP5_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = 0, .dep_vdd_volt = 0},
> > +};
> 
> This 34xx table has 4430 OPP voltages for CORE, which are clearly not
> right.  34xx has 3 CORE voltages to pick from, so I'm not sure which
> ones are right
> 
> Please update this with the correct 34xx voltages and also validate on
> 34xx also.
> 
Is it known what subsystem dependencies there are?

What I've noticed on N900 that the DSS will stop working if core
voltage is scaled under OMAP3430_VDD_CORE_OPP3_UV. I.e. either if using
OMAP4430_VDD_CORE_OPP50_UV above or OMAP3430_VDD_CORE_OPP2 or 1.

-- 
Jarkko
