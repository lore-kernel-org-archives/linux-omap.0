From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 5/7] ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
Date: Fri, 13 Jun 2014 19:08:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406131907180.340@utopia.booyaka.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com> <1399283686-6127-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaFMTIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 15:08:13 -0400
In-Reply-To: <1399283686-6127-6-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, tony@atomide.com, balbi@ti.com, bcousson@baylibre.com, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

Hi Roger,

On Mon, 5 May 2014, Roger Quadros wrote:

> Add the sysconfig class bits for the Super Speed USB
> controllers
> 
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

As with the previous DRA7 hwmod patch, I'd like to get a Reviewed-by: and 
a Tested-by: before merging this one.


- Paul
