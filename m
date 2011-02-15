From: archit taneja <archit@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 14:00:38 +0530
Message-ID: <4D5A39AE.3030006@ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>	 <1297693307.2951.25.camel@deskari>	 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>  <4D5A00E8.4060701@ti.com> <1297754826.2289.9.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44305 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab1BOI3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 03:29:45 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F8Tg3m029621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 02:29:44 -0600
In-Reply-To: <1297754826.2289.9.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 15 February 2011 12:57 PM, Valkeinen, Tomi wrote:

<snip>

> I meant something like this:
>
> dispc.c:
>
> dispc_init()
> {
> 	/* did we have a pdev for dispc? if not, this needs to be dss.pdev */
> 	request_irq(platform_get_irq(dispc.pdev, 0), irq_handler, IRQF_SHARED, "dispc irq", foo);
> }
>
> irq_handler()
> {
> 	if (irq_can_be_shared) {
> 		check if the irq is for us. exit if not;
> 	}
>
> 	handle;
> }
>
> dsi.c:
>
> dsi_init()
> {
> 	request_irq(platform_get_irq(dsi.pdev, 0), irq_handler, IRQF_SHARED, "dsi irq", foo);
> }
>
> irq_handler()
> {
> 	if (irq_can_be_shared) {
> 		check if the irq is for us. exit if not;
> 	}
>
> 	handle;
> }
>

This approach looks clean, but isn't IRQF_SHARED used the other way 
around. One irq line and multiple handlers?

Regards,
Archit

