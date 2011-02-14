From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] OMAP4: DSS2: Adding fclk support for DPI interface
Date: Mon, 14 Feb 2011 18:02:22 +0200
Message-ID: <1297699342.2951.62.camel@deskari>
References: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47214 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab1BNQCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:02:23 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1EG2N5N003510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:02:23 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1EG2MDl010163
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:02:23 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1EG2MlG014503
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:02:22 -0600 (CST)
In-Reply-To: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2011-02-03 at 07:56 -0600, Murthy, Raghuveer wrote:
> - Adding dss_feature for DPLL fclk
> - Enabling pixel clock generation for DPI interface

A bit more description what the patch set is about would be nice. Also,
one line patch descriptions are a bit too short for anything else than
the most trivial patches.

Now to the actual patch contents:

DPLL is not a feature of the DSS, and I don't think we should have
dss_features for that. In fact, I think the whole DPLL code should be
moved from DSS to somewhere under arch/arm.

In a perfect world DSS could just set the dss_fck to whatever rate it
requires, but as the clock rate can only be set to certain rates, and we
need a precise control for the rate, some other method has to be in
place.

I am not sure what this method should be. Perhaps there is something in
the clock framework that could help us here, or perhaps we just need a
bunch of function pointers in the DSS's platform data which can be used
to configure the clock.

 Tomi


