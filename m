From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 2/2] OMAP3:clk: introduce DPLL4 jtype support
Date: Tue, 20 Oct 2009 09:50:05 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AAFD04C@dlee02.ent.ti.com>
References: <1256035738-17571-1-git-send-email-nm@ti.com>
 <1256035738-17571-2-git-send-email-nm@ti.com>
 <1256035738-17571-3-git-send-email-nm@ti.com>
 <A24693684029E5489D1D202277BE89444CFD9B75@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162039B3CE7F2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33966 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbZJTOuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 10:50:02 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9KEo6fe032081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:50:06 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9KEo6hf009862
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:50:06 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9KEo596011057
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:50:05 -0500 (CDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B3CE7F2@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>

> From: Woodruff, Richard
> Sent: Tuesday, October 20, 2009 9:48 AM
> 
> 
> > From: Aguirre Rodriguez, Sergio Alberto
> > Sent: Tuesday, October 20, 2009 9:16 AM
> 
> > > + * lookup_dco_sddiv -j-type DPLL4 compensation variables
> >
> > Put a space before the j-type, and add better description.
> > Doesn't clarify what it really does IMHO:
> >
> > Something like:
> > "* lookup_dco_sddiv - Set j-type DPLL4 compensation variables"
> 
> For 45nm it was necessary to use a different DPLL IP for DPLL4 (dpllj).
> The other DPLLs are same which was used in 65nm (dpllm).  The register
> interface is slightly different.
> 
> Code could have said is type A or B, but simple choice was to follow
> internal name convention.
> 
Any comments on a neat handling of condition where clk->parent is NULL? A BUG_ON(!clk->parent) is good?

Regards,
Nishanth Menon
