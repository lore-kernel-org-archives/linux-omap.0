From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM/dts: omap3: Fix mcbsp2/3 hwmods to be able to
 probe the drivers for audio
Date: Mon, 22 Oct 2012 13:38:01 -0700
Message-ID: <20121022203800.GH4730@atomide.com>
References: <1350552307-10226-1-git-send-email-peter.ujfalusi@ti.com>
 <507FD32C.7010108@ti.com>
 <508530CE.9000703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61495 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752710Ab2JVUiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 16:38:04 -0400
Content-Disposition: inline
In-Reply-To: <508530CE.9000703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> [121022 04:42]:
> Hi Tony,
>=20
> On 10/18/2012 12:00 PM, Benoit Cousson wrote:
> > On 10/18/2012 11:25 AM, Peter Ujfalusi wrote:
> >> Fixes the following errors:
> >> [    2.318084] omap-mcbsp 49022000.mcbsp: invalid rx DMA channel
> >> [    2.324432] omap-mcbsp 49024000.mcbsp: invalid rx DMA channel
> >>
> >> Which is because we failed to link the sidetone hwmod for McBSP2/3=
=2E The
> >> missing sidetone hwmod link will prevent omap_device_alloc() to ap=
pend the
> >> DMA resources since we - accidentally - end up having the same num=
ber of
> >> resources provided from DT (IO/IRQ) as we have in hwmod for the Mc=
BSP ports
> >> without the ST resources.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >=20
> > Acked-by: Benoit Cousson <b-cousson@ti.com>
>=20
> Can you take this patch for -rc3?

Thanks will apply into omap-for-v3.7-rc2/fixes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
