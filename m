From: Matt Porter <mporter@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Mon, 21 Jan 2013 13:24:19 -0500
Message-ID: <20130121182419.GE10020@beef>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk>
 <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:45877 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab3AUSYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 13:24:22 -0500
Received: by mail-qa0-f51.google.com with SMTP id i20so4808616qad.3
        for <linux-omap@vger.kernel.org>; Mon, 21 Jan 2013 10:24:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Mon, Jan 21, 2013 at 06:20:03PM +0000, Richard Cochran wrote:
> On Mon, Jan 21, 2013 at 10:45:10AM -0600, Nishanth Menon wrote:
> > for MMC filesystem - we need the edma series. for a ramdisk, I am able
> > to boot up to shell with 3.8-rc4 tag
> 
> Yep, I also could boot 3.8-rc3 using ramfs, no problem.

Do you use appended dtb? The only different that jumped out at me first
Paul's reported hang is he uses appended dtb and I boot my boards with a
single uImage and multiple dtbs the traditional DT way.

-Matt
