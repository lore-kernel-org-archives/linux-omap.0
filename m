From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAP: DSS2: DSI Driver: udelays/timeouts
Date: Thu, 07 Jan 2010 14:15:20 +0200
Message-ID: <1262866520.2127.35.camel@tubuntu.research.nokia.com>
References: <1260535578453.juha_motorsportcom.50821.UM-uY0GfylC9tNgYiVGtKg@luukku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47078 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab0AGMOz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 07:14:55 -0500
In-Reply-To: <1260535578453.juha_motorsportcom.50821.UM-uY0GfylC9tNgYiVGtKg@luukku.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Juha Leppanen <juha_motorsportcom@luukku.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2009-12-11 at 13:46 +0100, ext Juha Leppanen wrote:
> Hi,
> 
> checking some patches thru www.kernel.org
> 
> /drivers/video/omap2/dss/dsi.c
> 
> I noticed in many places that if timeout happens,
> while "read/status/check" is not done after the last Nth udelay.
> Why not "check" after the last udelay?

Thanks, I will make the checks consistent.

 Tomi


