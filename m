From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 06/17] OMAP2,3 board files DSS Driver register moved
 to devices.c
Date: Tue, 21 Dec 2010 15:59:02 +0200
Message-ID: <1292939942.22441.60.camel@tubuntu>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
	 <1291031503-21036-7-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:45744 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab0LUN7J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 08:59:09 -0500
In-Reply-To: <1291031503-21036-7-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hi,

On Mon, 2010-11-29 at 17:21 +0530, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Move DSS driver register from board file to devices.c
> Regulator initialisation done with driver name instead
> of device structure name.
> Changed driver name from omapdss to omap_display as the
> driver takes care of panel information.
> Board files that have dss registeration are updated.
> 3430sdp, am3517evm, cm-t35, devkit8000, igep0020,
> omap3evm, omap3pandora, omap3stalker, rx-51

Here are also too many changes in one patch. Change the driver name
first (could be done in the previous patches), then the regulator
initialization, and then the omap_display_init() change.

 Tomi


