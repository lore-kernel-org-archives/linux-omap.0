From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: Check process context in bridge_ioctl
Date: Tue, 2 Feb 2010 14:17:54 -0600
Message-ID: <4B688872.9050403@ti.com>
References: <818EF96F5A7CC84789DD014773DB095484859F55@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445Ab0BBUSA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 15:18:00 -0500
In-Reply-To: <818EF96F5A7CC84789DD014773DB095484859F55@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 1/27/2010 12:06 PM, Gomez Castellanos, Ivan wrote:
>  From f9d2f46583399c4addd3c2978c62d1821e0100d7 Mon Sep 17 00:00:00 2001
> From: Ivan Gomez<ivan.gomez@ti.com>
> Date: Thu, 21 Jan 2010 12:27:33 -0600
> Subject: [PATCH] DSPBRIDGE: Check process context in bridge_ioctl
>
> Check pcontext (filp->private_data) in bridge_ioctl function,
> so that additional pcontext checks can be removed.
>
> Signed-off-by: Ivan Gomez<ivan.gomez@ti.com>
> ---
>   drivers/dsp/bridge/rmgr/drv.c           |   32 +++---------------------------
>   drivers/dsp/bridge/rmgr/drv_interface.c |   19 ++++++++++-------
>   drivers/dsp/bridge/rmgr/node.c          |    6 +----
>   drivers/dsp/bridge/rmgr/proc.c          |    7 ++---
>   4 files changed, 19 insertions(+), 45 deletions(-)
>

Pushed to dspbridge.

- omar
