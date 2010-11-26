From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: Clean up DISPC color mode validation checks
Date: Fri, 26 Nov 2010 12:33:38 +0200
Message-ID: <1290767618.5382.31.camel@nubuntu>
References: <1290688090-27319-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:46746 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342Ab0KZKdp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 05:33:45 -0500
In-Reply-To: <1290688090-27319-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, 2010-11-25 at 17:58 +0530, ext Archit Taneja wrote:
> The supported set of color modes varies for different DISPC pipelines(plane)
> and omap version. This makes the checks for validation of a color mode more
> complicated as new omap versions are added.
> 
> A dss_feature function is created which tells if a color_mode is supported
> for a plane on the current omap revision.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |   53 +++-----------------------------
>  drivers/video/omap2/dss/dss_features.c |    7 ++++
>  drivers/video/omap2/dss/dss_features.h |    2 +
>  3 files changed, 14 insertions(+), 48 deletions(-)

Looks good to me, thanks!

 Tomi


