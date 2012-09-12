From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Cleanup the omap2_mcspi_txrx_dma function
Date: Wed, 12 Sep 2012 11:40:06 +0530
Message-ID: <5050273E.3080407@ti.com>
References: <1347345800-4116-1-git-send-email-shubhrajyoti@ti.com> <20120912032135.GJ9162@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37019 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756280Ab2ILGKM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 02:10:12 -0400
Received: by obbuo13 with SMTP id uo13so2102637obb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 23:10:11 -0700 (PDT)
In-Reply-To: <20120912032135.GJ9162@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: spi-devel-general@lists.sourceforge.net, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 12 September 2012 08:51 AM, Mark Brown wrote:
> On Tue, Sep 11, 2012 at 12:13:20PM +0530, Shubhrajyoti D wrote:
>> > Currently in omap2_mcspi_txrx_dma the tx and the rx support is
>> > interleaved. Make the rx related code in omap2_mcspi_rx_dma
>> > and the tx related code omap2_mcspi_tx_dma and call the functions.
> I'd ideally like some testing from the OMAP side before applying this -
> is there someone who can give a Tested-by?
I have tested this patch with nfs boot with ethernet being on spi on
omap4sdp and spidev.
On omap3 sdp tested the touchscreen.

However can wait for some tested-bys :-)
