From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [CFT 07/11] spi: omap2-mcspi: add DMA engine support
Date: Mon, 18 Jun 2012 12:11:50 +0530
Message-ID: <4FDECDAE.8070700@ti.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk> <20120614115335.GE31187@n2100.arm.linux.org.uk> <20120614120842.GF31187@n2100.arm.linux.org.uk> <20120614125012.GG31187@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:44746 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308Ab2FRGl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 02:41:57 -0400
Received: by obcva7 with SMTP id va7so31763obc.20
        for <linux-omap@vger.kernel.org>; Sun, 17 Jun 2012 23:41:55 -0700 (PDT)
In-Reply-To: <20120614125012.GG31187@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net

On Thursday 14 June 2012 06:20 PM, Russell King - ARM Linux wrote:
> because, at the time when omap2_mcspi_setup() is called, spi->dev is
> not bound, and so is outside of the devres valid lifetime of that
> struct device.
Agree,
Apologies for breaking in the initial commit.
