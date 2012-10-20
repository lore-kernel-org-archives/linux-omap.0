From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 06:14:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53121 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab2JTGOL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 02:14:11 -0400
In-Reply-To: <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: balbi@ti.com, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi Jean

On Fri, 19 Oct 2012, Paul Walmsley wrote:

> On Thu, 18 Oct 2012, Paul Walmsley wrote:
> 
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/

...

> > Failing tests: needing investigation
> > ------------------------------------
> >
> > Boot tests:
> 
> * 3530ES3 Beagle: I2C timeouts during userspace init
>   - May be related to the threaded IRQ conversion of the I2C driver
>   - Unknown cause

This one turned out to be caused by:

commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc
Author: Jean Pihet <jean.pihet@newoldbits.com>
Date:   Thu Sep 20 18:08:03 2012 +0200

    ARM: OMAP: convert I2C driver to PM QoS for MPU latency constraints


Reverting this commit causes the problem to go away, but since the OMAP PM 
constraint code was removed as well, it's unlikely that a simple revert is 
the right thing to do.

Jean could you please investigate and fix this?


- Paul
