From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] ARM: DRA7: hwmod: fixes for 3.16
Date: Mon, 23 Jun 2014 04:57:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406230450460.27636@utopia.booyaka.com>
References: <1403093816-10960-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51246 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaFWE5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2014 00:57:32 -0400
In-Reply-To: <1403093816-10960-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, rnayak@ti.com, nm@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Roger

On Wed, 18 Jun 2014, Roger Quadros wrote:

> These patches add the missing OCP2SCP3 module and fixup the SATA hwmod
> for DRA7 SoC. Both patches are tested on 3.16-rc1.

Could you please post a quick serial capture of a boot log for these 
patches, as Felipe has done for other patches?

thanks,

- Paul
