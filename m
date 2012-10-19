From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 19 Oct 2012 22:03:58 +0300
Message-ID: <20121019190358.GI1613@blackmetal.musicnaut.iki.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:39538 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab2JSTED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 15:04:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Oct 19, 2012 at 04:55:38PM +0000, Paul Walmsley wrote:
> On Thu, 18 Oct 2012, Paul Walmsley wrote:
> 
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
> 
> And here's two more.

[...]

> * 3530ES3 Beagle: I2C timeouts during userspace init
>   - May be related to the threaded IRQ conversion of the I2C driver
>   - Unknown cause

FYI, I saw I2C hangs also on Nokia N900 with v3.7-rc1 (omap_i2c
omap_i2c.1: timeout waiting for bus ready). After several reboots they
disappered (kernel binary was the same), and I have been unable to
reproduce them since.

A.
