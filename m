From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: Introduce dss_features files
Date: Tue, 07 Sep 2010 13:23:05 +0300
Message-ID: <1283854985.2363.47.camel@tubuntu.research.nokia.com>
References: <1282826618-24584-1-git-send-email-archit@ti.com>
	 <1282826618-24584-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:33410 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab0IGKXL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 06:23:11 -0400
In-Reply-To: <1282826618-24584-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2010-08-26 at 14:43 +0200, ext Archit Taneja wrote:
> Add dss_features.c and dss_features.h for the dss_features framework
> 
> Signed-off-by: Archit Taneja <archit@ti.com>

Would a more static approach be cleaner? I mean something like this
(pseudo code):

static struct omap_dss_features omap3_dss_features = {
	/* array of register definitions */
	.registers = {
		{
			.register = FIRHINC,
			.high = 12,
			.low = 0,
		},
		{
			.register = FIRVINC,
			.high = 28,
			.low = 16,
		},
		...
	},

	/* array of feature ids */
	.features = {
		GLOBAL_ALPHA,
		GLOBAL_ALPHA_VIDEO1,
		...
	},
};

And then the code would select the omapX_dss_features struct to use
depending on the omap version.

Also, the feature/register defines should have some prefix, and perhaps
they could be inside an enum?

 Tomi


