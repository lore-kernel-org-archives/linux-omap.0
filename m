From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 05/14] OMAPDSS: DSI: add enum omap_dss_dsi_trans_mode
Date: Wed, 20 Mar 2013 17:00:46 +0530
Message-ID: <51499DE6.4060008@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58677 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757505Ab3CTLbd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Mar 2013 07:31:33 -0400
In-Reply-To: <1362743569-10289-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:
> Instead of managing DSI sync ends with booleans, add an enum for the DSI
> transfer mode. This is much cleaner way to handle the DSI syncs.

This sort of DSI protocol specific enums should definitely get into the 
CDF encoder drivers, maybe even in include/video/mipi_display.h for the 
time CDF is being worked upon.

Archit

