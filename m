From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 09:27:06 +0200
Message-ID: <1297754826.2289.9.camel@deskari>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
	 <1297693307.2951.25.camel@deskari>
	 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>  <4D5A00E8.4060701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44217 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab1BOH1K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 02:27:10 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F7R90i016111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 01:27:09 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1F7R89V009473
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 01:27:09 -0600 (CST)
In-Reply-To: <4D5A00E8.4060701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-02-14 at 22:28 -0600, Taneja, Archit wrote:
> Hi,
> 
> On Monday 14 February 2011 08:00 PM, Balbi, Felipe wrote:
> > Hi,
> >
> > On Mon, Feb 14, 2011 at 04:21:47PM +0200, Tomi Valkeinen wrote:
> >> On Wed, 2011-02-02 at 08:56 +0000, archit taneja wrote:
> >>> OMAP2 has an irq line dedicated for DISPC interrupts, there is no DSI
> >>> on omap2.
> >>> OMAP3 has a common irq line for DISPC and DSI interrupts.
> >>> OMAP4 has seperate irq lines for DISPC and DSI Interrupts.
> >>>
> >>> Use dss_features to have a common DSS irq handler for all OMAP revisions.
> >>>
> >>> Also, use a member of the global dss structure to store the irq number
> >>> as it is used in 2 functions.
> >>
> >> It's good to remove the cpu_is_xxxx() calls, but I'm not quite sure
> >> about this patch...
> >>
> >> Could we use shared interrupt handlers here, so that dss.c would handle
> >> only DISPC interrupts (or should it be even in dispc.c?) and dsi.c would
> >> handle DSI interrupts?
> 
> Could you elaborate this a bit more?

I meant something like this:

dispc.c:

dispc_init()
{
	/* did we have a pdev for dispc? if not, this needs to be dss.pdev */
	request_irq(platform_get_irq(dispc.pdev, 0), irq_handler, IRQF_SHARED, "dispc irq", foo);
}

irq_handler()
{
	if (irq_can_be_shared) {
		check if the irq is for us. exit if not;
	}

	handle;
}

dsi.c:

dsi_init()
{
	request_irq(platform_get_irq(dsi.pdev, 0), irq_handler, IRQF_SHARED, "dsi irq", foo);
}

irq_handler()
{
	if (irq_can_be_shared) {
		check if the irq is for us. exit if not;
	}

	handle;
}


> 
> >>
> >> On OMAP3 both dss.c and dsi.c would register to the same interrupt, and
> >> they would need to check if the interrupt was really for them. On OMAP4
> >> the code could be the same, even though the check is unnecessary.
> 
> The code can't be exactly the same. The DSS_IRQSTATUS register used on 
> OMAP3 doesn't exist on OMAP4. A read to this register on OMAP4 would 
> cause a hang/crash.

Ok, we need a dss_feature bit for this then.

 Tomi


