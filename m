From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/6] OMAP: ID: introduce chip detection for OMAP4460
Date: Fri, 8 Jul 2011 00:39:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080039330.24181@utopia.booyaka.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com> <1309573826-10615-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41911 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab1GHGjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 02:39:53 -0400
In-Reply-To: <1309573826-10615-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>, Nishanth Menon <nm@ti.com>

On Sat, 2 Jul 2011, Rajendra Nayak wrote:

> From: Aneesh V <aneesh@ti.com>
> 
> Add support for detecting the latest in the OMAP4 family: OMAP4460
> Among other changes, the new chip also can support 1.5GHz A9s,
> 1080p stereoscopic 3D and 12 MP stereo (dual camera). In addition,
> we have changes to OPPs supported, clock tree etc, hence having a
> chip detection is required.
> 
> For more details on OMAP4460, see
> Highlights:
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?contentId=53243&navigationId=12843&templateId=6123
> Public TRM is available here as usual:
> http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?templateId=6123&navigationId=12667
> 
> [nm@ti.com: cleanups and introduction of ramp system]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

- Paul
