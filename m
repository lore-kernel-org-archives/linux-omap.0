From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [Patch v3 0/2] OMAP2PLUS:DSS2: use opt-clocks information from
 hwmod.
Date: Tue, 1 Mar 2011 18:26:21 +0200
Message-ID: <1298996781.2049.18.camel@deskari>
References: <1298968934-22697-1-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50951 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922Ab1CAQ0Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 11:26:24 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21GQOQJ022506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 10:26:24 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p21GQONO000769
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 10:26:24 -0600 (CST)
In-Reply-To: <1298968934-22697-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 02:42 -0600, Semwal, Sumit wrote:
> This series uses information about opt-clocks provided by omap_hwmod framework
> to select which of the non-mandatory DSS clocks are available on a given
> platform.
> 
> A function pointer opt_clock_available is exported via pdata, which checks the
> clock roles returned by hwmod database.
> In the driver, while doing clk-get, it is checked if as per hwmod a given clock
> is an opt-clock or not, and is handled accordingly.
> 
> Tested on: OMAP3430sdp
> 
> Sumit Semwal (2):
>   OMAP2PLUS:DSS2: add opt_clock_available in pdata
>   OMAP2PLUS:DSS2: Use opt_clock_available from pdata

I think this set looks fine now. Applying.

 Tomi


