From: archit taneja <archit@ti.com>
Subject: Re: [PATCH 2/3] OMAP: DSS2: Use request / release calls in Taal for
 DSI Virtual Channels.
Date: Tue, 1 Mar 2011 18:04:37 +0530
Message-ID: <4D6CE7DD.5020206@ti.com>
References: <1298982743-6771-1-git-send-email-archit@ti.com> <1298982743-6771-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59749 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321Ab1CAMbr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 07:31:47 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21CVi8t010827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 06:31:46 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p21CViXf011526
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 18:01:44 +0530 (IST)
In-Reply-To: <1298982743-6771-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Please ignore this particular patch of the series. Sent accidentally.

Thanks,
Archit
On Tuesday 01 March 2011 06:02 PM, Taneja, Archit wrote:
> Taal driver used to take a hard coded Macro for Virtual Channel and the VC_ID.
> The Taal panel driver now requests for a Virtual channel through the
> omap_dsi_request_vc() call in taal_probe().
>
> The channel number returned by the request_vc() call is used for sending command
> and data to the Panel. The DSI driver automatically configures the Virtual
> Channel's source to either Video Port or L4 Slave port based on what the panel
> driver is using it for.
>
> The driver uses omap_dsi_release_vc() to free all the VC's requested by it in
> taal_remove() or when a request_vc() call fails.
>
> Signed-off-by: Archit Taneja<archit@ti.com>
> ---
>   drivers/video/omap2/displays/panel-taal.c |  123 +++++++++++++++++------------
>   drivers/video/omap2/dss/dsi.c             |    3 -
>   2 files changed, 71 insertions(+), 55 deletions(-)
>
