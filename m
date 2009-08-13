From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH v2 1/6] ARM: OMAP4: PM: Fix the PRM and CM base addresses
Date: Thu, 13 Aug 2009 08:06:51 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A783459@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89444A6ED4DB@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0306050809@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38520 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbZHMNDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 09:03:23 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0306050809@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Rajendra,

<snip>

> >> +#define OMAP4430_CM1_BASE		0x4a004000
> >> +#define OMAP4430_CM_BASE		OMAP4430_CM1_BASE
> >
> >Why do you need 2 defines for the same value?
> 
> Hi Sergio,
> PRCM had just one CM module in OMAP2/3 and OMAP4 has
> 2 of them , CM1 and CM2.

That I can understand...

> The older CM defines are now mapped to CM1
> for OMAP4 and new ones created for CM2.

Ok, but if you're trying to set that convention, IMHO either keep one or the another.

For example, you can keep only this definition:

#define OMAP4430_CM1_BASE		0x4a004000

And change in all the currently merged code from CM to CM1...

Anyways, its just my thoughts... Of course you're free to take them or not.

Thanks and Regards,
Sergio

> 
> regards,
> Rajendra
> >
> >Regards,
> >Sergio
> >
> >> +#define OMAP4430_CM2_BASE		0x4a008000
> >> +#define OMAP4430_PRM_BASE		0x4a306000
> >>  #define OMAP44XX_GPMC_BASE		0x50000000
> >>  #define OMAP443X_SCM_BASE		0x4a002000
> >>  #define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
> >> --
> >> 1.5.4.7
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
