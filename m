From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [REVIEW PATCH 14/14] OMAP34XX: CAM: Add Sensors Support
Date: Mon, 15 Dec 2008 11:02:35 -0600
Message-ID: <A24693684029E5489D1D202277BE894415F3DAEB@dlee02.ent.ti.com>
References: <20081215162338.GS10664@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbYLORDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 12:03:02 -0500
In-Reply-To: <20081215162338.GS10664@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>

> From: Tony Lindgren [mailto:tony@atomide.com]
> * Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [081211 12:44]:
> > +	case V4L2_POWER_OFF:
> > +		/* Power Down Sequence */
> > +#ifdef CONFIG_TWL4030_CORE
> > +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> > +				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
> > +#else
> > +#error "no power companion board defined!"
> > +#endif
> 
> These checks look unecessary. How about just handle it with Kconfig?
> 
[Aguirre, Sergio] But how? Don't you think that if I do that, I'll tighten the sensor driver to this board only?

