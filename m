From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v4 1/2] OMAP: DSS2: Introduce dss_features files
Date: Thu, 07 Oct 2010 10:09:25 +0300
Message-ID: <1286435365.28499.1012.camel@tubuntu.research.nokia.com>
References: <1284559794-4771-1-git-send-email-archit@ti.com>
	 <1284559794-4771-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:23141 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab0JGHJc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 03:09:32 -0400
In-Reply-To: <1284559794-4771-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext archit@ti.com" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2010-09-15 at 16:09 +0200, ext archit@ti.com wrote:
> From: Archit Taneja <archit@ti.com>
> 
> Add dss_features.c and dss_features.h for the dss_features framework
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---

<snip> 

> +struct omap_dss_features {
> +	const struct dss_reg_field *reg_fields;
> +	const int num_reg_fields;
> +
> +	const u32 has_feature;

I only now noticed that you had changed the feature list to a bit array.
It was an array of ints previously. Are you sure 32 features is enough?
It sounds a bit small to me.

 Tomi


