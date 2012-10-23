From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Tue, 23 Oct 2012 03:15:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210230311490.31118@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com> <50857444.9080308@ti.com> <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com> <50859505.5010306@ti.com> <20121023015346.GB1855@beef>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57815 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab2JWDPp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 23:15:45 -0400
In-Reply-To: <20121023015346.GB1855@beef>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 22 Oct 2012, Matt Porter wrote:

> I've mentioned this a few times in various threads...no need to use
> appended DTB on a current U-Boot. Some of us are indeed booting this way
> with the DTB properly passed separately from the bootloader and chosen
> filled out by the bootloader. And yes, am335x_evm_config applies to all
> AM33xx TI EVMs and the BeagleBone board. There's an EEPROM onboard all
> that is used to determine what board is present so a single
> MLO/u-boot.img can be used.

As Kevin mentioned earlier, this is unfortunately not true for those of us 
with earlier BeagleBoards:

   http://marc.info/?l=linux-omap&m=135094296931913&w=2

Do you know what the minimum board revision is that you all are 
supporting in U-boot?



- Paul
