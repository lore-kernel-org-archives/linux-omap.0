From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Tue, 1 Jun 2010 10:14:09 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E538286@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
 <20100601094358.GJ841@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49194 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab0FAPOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 11:14:14 -0400
In-Reply-To: <20100601094358.GJ841@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Hi Tony,

> Please test this with omap3_defconfig too, and make sure it does not break
> things for omap2 and omap3.

Tested, no problems...

> > +int omap4_init_kp(struct omap4_keypad_platform_data *kp)
> > +{
> > +	struct omap_hwmod *oh;
> > +	struct omap_device *od;
> > +	struct omap4_keypad_platform_data *pdata;
> > +
> > +	unsigned int length = 0, id = 0;
> > +	int hw_mod_name_len = 16;
> > +	char oh_name[hw_mod_name_len];
> > +	char *name = "omap4-keypad";
> 
> 	if (!cpu_is_omap44xx())
> 		return -ENODEV;

I am using #ifdef CONFIG_ARCH_OMAP4 for this portion of code, what you are suggesting is to check at runtime?

Best Regards
Abraham
