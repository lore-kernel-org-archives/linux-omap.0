From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 00/13] ARM: OMAP: remove prcm.[ch]
Date: Wed, 31 Oct 2012 05:29:05 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB52A6E@DBDE01.ent.ti.com>
References: <20121025231818.17558.57884.stgit@dusk.lan>
 <508E5B65.2020800@ti.com>
 <alpine.DEB.2.00.1210301156310.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38428 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab2JaF3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 01:29:16 -0400
In-Reply-To: <alpine.DEB.2.00.1210301156310.12697@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 30, 2012 at 17:27:02, Paul Walmsley wrote:
> On Mon, 29 Oct 2012, Vaibhav Hiremath wrote:
> 
> > 
> > 
> > On 10/26/2012 4:51 AM, Paul Walmsley wrote:
> > > Remove arch/arm/mach-omap2/prcm.c and
> > > arch/arm/plat-omap/include/plat/prcm.h.  This is in preparation for
> > > moving the PRM/CM code to drivers/, although to be fair, these files
> > > should have been removed a long time ago.
> > > 
> > > Intended for 3.8 cleanup.  Applies on top of the existing PRM/CM split
> > > cleanup series, and the WDTIMER cleanup series.
> > > 
> > 
> > Paul,
> > 
> > By any chance you have branch available with these patches, so that I
> > can validate them here at my end?
> 
> The current version is at
> 
> git://git.pwsan.com/linux-2.6
> 
> in the branch
> 
> prcm_cleanup_b_3.8
> 

Boot tested on BeagleBone platform.

Tested-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> 
> - Paul
> 

