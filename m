From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v4 0/2] OMAP: DSS2: Framework to handle omap version
 specific DSS features
Date: Thu, 07 Oct 2010 11:27:24 +0300
Message-ID: <1286440044.28499.1027.camel@tubuntu.research.nokia.com>
References: <1284559794-4771-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:35404 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab0JGI1a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 04:27:30 -0400
In-Reply-To: <1284559794-4771-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext archit@ti.com" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-09-15 at 16:09 +0200, ext archit@ti.com wrote:
> From: Archit Taneja <archit@ti.com>
> 
> This is a simple approach to prevent scattered cpu_is_omapxxxx checks
> in DSS2 by bringing all omap version specific DSS features/values to one
> single place, initialize them and expose a set of functions to DSS2 driver
> files which return the value/existance of a feature.
> 
> This method provides the following:
>   -A set of functions which give the value of a feature.
>   -Functions which add and return the start and end bits of a register field
>    which varies across omaps.
>   -A function which checks if a DSS2 feature exists or not on the present
>    omap (omap_dss_has_feature)
> 
> Whenever a new DSS feature is introduced, its value/existance is specified
> for all omaps in omap_dss_feature_init().
> 
> This patch also fills up a minimal list of features in omap_dss_features_init().
> The second patch in the series makes use of dss_features to remove some of the
> existing omapxxxx checks.

Thanks, applied to DSS2 tree.

 Tomi


