From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: Generalize DSS clock source names
Date: Mon, 28 Feb 2011 14:29:35 +0200
Message-ID: <1298896175.9809.33.camel@deskari>
References: <1298875837-6305-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58306 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1B1M3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 07:29:39 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1SCTdT2010304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:29:39 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1SCTciG014405
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:29:38 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1SCTc68008153
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:29:38 -0600 (CST)
In-Reply-To: <1298875837-6305-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2011-02-28 at 00:50 -0600, Taneja, Archit wrote:
> The OMAP Display Subsystem has multiple clock sources available for its
> modules. One of these sources has to be selected through a global control
> register called DSS_CTRL.
> 
> For example, on OMAP4, the Display Controller Module's (DISPC) functional
> clock can be derived from:
> a) output of DPLL_PER's M5 divisor
> b) output of DSI1 PLL's M4 divisor
> c) output of DSI2 PLL's M4 divisor
> d) output of HDMI PLL
> 
> There is, hence, an enum called 'dss_clk_source' which is used throughout
> DSS2, to select clock sources for various DSS sub modules. These clock
> source names are currently specific to OMAP2/3 TRM clock names.
> 
> All enum members, variables, functions which are based on these clock
> source names have been made generic such that they can be used for future
> OMAPs as well.
> 
> Archit Taneja (3):
>   OMAP2PLUS: DSS2: Make members of dss_clk_source generic
>   OMAP2PLUS: DSS2: Use dss features to get clock source names of
>     current OMAP
>   OMAP2PLUS: DSS2: DSI: Generalize DSI PLL Clock Naming

This patch set, and also the two individual patches for using
dss_features, look ok. However, they don't apply to DSS tree. Can you
rebase these on top of DSS master branch, please?

 Tomi


