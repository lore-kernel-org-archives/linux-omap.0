From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 21 May 2014 08:03:14 -0700
Message-ID: <20140521150314.GI17417@atomide.com>
References: <1400663706-24104-1-git-send-email-florian.vaussard@epfl.ch>
 <537C962F.6050104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26183 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751616AbaEUPDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 11:03:19 -0400
Content-Disposition: inline
In-Reply-To: <537C962F.6050104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:04]:
> On 21/05/14 12:15, Florian Vaussard wrote:
> > Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
> > board.
> > 
> > Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> > ---
> > v1->v2:
> > - Rebased on Tony's omap-for-v3.16/dt-v2
> > - Use OMAP4_IOPAD macro
> > - Use hpd pin as GPIO with hdmi-connector
> > 
> >  arch/arm/boot/dts/omap4-duovero-parlor.dts | 44 ++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> 
> Looks good to me.

Assuming Tomi will queue the display dts file separately:

Acked-by: Tony Lindgren <tony@atomide.com>
