From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4] MIPI DSI support for SH-mobile, common header, switch
 OMAP to use it
Date: Fri, 7 May 2010 11:07:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751878Ab0EGJHM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 05:07:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

This patch series adds support for the MIPI DSI unit on sh-mobile SoCs, to 
eliminate redundancy a common mipi_dsi.h header is added. The SH-mobile 
part depends on pending clock and INTC patches by Magnus.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
