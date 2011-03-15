From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP2PLUS: DSS2: FEATURES: Fix usage of dss_reg_field
 and dss_clk_source_name
Date: Tue, 15 Mar 2011 11:57:22 +0530
Message-ID: <1300170442.1946.15.camel@lappyti>
References: <1300163303-31662-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43723 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab1COG12 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 02:27:28 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2F6RPlO022548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 01:27:27 -0500
In-Reply-To: <1300163303-31662-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-03-14 at 23:28 -0500, Taneja, Archit wrote:
> The structures dss_reg_field and dss_clk_source_name have enum members which
> specify the register field and the clock source respectively. These members are
> not used to choose the correct result in the corresponding feature functions.
> Remove these members and change the features array declaration to incorporate
> these enums.
> 
> The structure dss_clk_source_name without the enum member is just a pointer to
> an string. Remove the structure and use a character pointer directly.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c          |   10 ++--
>  drivers/video/omap2/dss/dss.h          |    6 ---
>  drivers/video/omap2/dss/dss_features.c |   77 ++++++++++++++++----------------
>  3 files changed, 43 insertions(+), 50 deletions(-)

Thanks, looks good to me.

 Tomi


