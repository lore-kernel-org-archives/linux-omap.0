From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.16-rc1 & default cachepolicy
Date: Fri, 20 Jun 2014 11:57:59 +0300
Message-ID: <20140620085759.GG558@drone.musicnaut.iki.fi>
References: <20140619203655.GE558@drone.musicnaut.iki.fi>
 <20140619205853.GH3705@n2100.arm.linux.org.uk>
 <20140619224004.GF558@drone.musicnaut.iki.fi>
 <20140619233626.GI3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:53594 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbaFTI6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2014 04:58:08 -0400
Content-Disposition: inline
In-Reply-To: <20140619233626.GI3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Jun 20, 2014 at 12:36:26AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 20, 2014 at 01:40:04AM +0300, Aaro Koskinen wrote:
> > So I tried the below change. But now it hangs early, even before
> > the earlyprintk is working. :-/
> 
> Thanks for trying.  I notice you said "write-through", so can you
> drop the PMD_SECT_BUFFERABLE flag and try again please?

Yes, that works.

A.
