From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: RE: [PATCH]i2c-omap: pass scll, sclh through board file for Errata
 i585
Date: Mon, 10 May 2010 20:32:55 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E4049A4@dbde02.ent.ti.com>
References: <1273214105-22894-1-git-send-email-balajitk@ti.com>
 <4BE3DD36.10308@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab0EJPDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 11:03:22 -0400
In-Reply-To: <4BE3DD36.10308@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>


> -----Original Message-----
> From: Aaro Koskinen [mailto:aaro.koskinen@nokia.com]
> Subject: Re: [PATCH]i2c-omap: pass scll, sclh through board file for Errata
> i585
> 
> Hi,
> 
> balajitk@ti.com wrote:
> > From: Balaji T K <balajitk@ti.com>
> >
> > Errata ID: i535 - I2C1 to 3 SCL low period is shorter in FS mode
> > Due to IO cell influence, I2C1 to 3 SCL low period can be shorter than
> expected.
> > As a result, I2C AC timing (SCL minimum low period) in FS mode may not meet
> > the timing configured by software.
> >
> > I2C1 to 3, SCL low period is programmable and proper adjustments
> > to the SCLL/HSSCLL values can avoid the issue.
> >
> > This patch provides flexibility to control tLOW, tHIGH for different boards.
> > scll, sclh values are to be provide in board data
> > for differents modes (standard, fast and high speed mode)
> > as the scl rate (I2C bus speed) can be changed by bootargs.
> 
> This patch is very much needed, because these values are highly board
> specific.
> At the moment we are forced to patch the i2c bus driver when finetuning the
> I2C
> timings for a certain board, which is ugly.
> 
> However, I have comment one about the implementation:
> 

<snip>

> I think it would be simpler if we move these calcuations into a function.
> E.g. something like:
> 
If the custom function is also to fine the scl low and scl high values.
How about passing the Tlow to T, Thigh to T ratio. T = 1/100Khz , 1/400Khz ,
1/HS speed to make things simpler.

> 	if (dev->speed > 400) {
> 		/* HS mode */
> 		pdata->set_scl(internal_clk, 400, &fsscll, &fssclh);
> 		pdata->set_scl(fclk_rate, dev->speed, &hsscll, &hssclh);
> 	} else {
> 		/* Fast & standard mode */
> 		pdata->set_scl(internal_clk, dev->speed, &fsscll, &fssclh);
> 	}
> 
> Then the default function would be something like:
> 
> static void omap_i2c_default_scl(unsigned clk, unsigned speed, u16 *scll, u16
> *sclh)
> {
> 	if (speed > 100) {
> 		/* Fast & HS modes */
> 		unsigned scl = clk / speed;
> 
> 		*scll = scl - (scl / 3) - 7;
> 		*sclh = (scl / 3) - 5;
> 	} else {
> 		/* Standard mode */
> 		*scll = clk / (speed * 2) - 7;
> 		*scll = clk / (speed * 2) - 5;
> 	}
> }
> 
> And the platform data would just provide a board-specific function if needed.
> 
> A.
