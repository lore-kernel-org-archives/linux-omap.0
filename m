From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 19/20] OMAPDSS: DSI: fix DSI channel source initialization
Date: Mon, 11 Mar 2013 11:40:18 +0530
Message-ID: <513D754A.4000607@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-20-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40636 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3CKGLA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 02:11:00 -0400
In-Reply-To: <1362743515-10152-20-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
> During the initialization of the DSI protocol registers, we always set
> the sources of all DSI channels to L4. However, we don't update the
> value in the dsi_data, so we may end up with a different value in the
> register and in the dsi_data, leading to DSI problems.
>
> This patch fixes the issue by initializing also the channel source in
> the dsi_data.

We set in omap_dsihw_probe:

static int __init omap_dsihw_probe(struct platform_device *dsidev)
{
	...
	...
         /* DSI VCs initialization */
         for (i = 0; i < ARRAY_SIZE(dsi->vc); i++) {
                 dsi->vc[i].source = DSI_VC_SOURCE_L4;
                 dsi->vc[i].dssdev = NULL;
                 dsi->vc[i].vc_id = 0;
         }
	...
	...
}

<snip>

Archit

