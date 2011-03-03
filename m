From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Thu, 3 Mar 2011 16:53:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103031652500.10981@utopia.booyaka.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com> <4D67E0C0.4080805@ti.com> <alpine.DEB.2.00.1103031614440.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47222 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1CCXxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 18:53:12 -0500
In-Reply-To: <alpine.DEB.2.00.1103031614440.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 3 Mar 2011, Paul Walmsley wrote:

> On Fri, 25 Feb 2011, Cousson, Benoit wrote:
> 
> >  static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
> >  	&omap3xxx_l3_main__l4_core,
> > -	&omap3_l4_core__sr1,
> > -	&omap3_l4_core__sr2,

Never mind, I see the issue now...


- Paul
