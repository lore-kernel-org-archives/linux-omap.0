From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH v2 0/5] Convert I2C driver to use omap_device/runtime PM
Date: Tue, 21 Sep 2010 11:16:43 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EE070@dbde02.ent.ti.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com>
 <87tylkwab4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0IUFqu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 01:46:50 -0400
In-Reply-To: <87tylkwab4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Monday, September 20, 2010 11:46 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v2 0/5] Convert I2C driver to use omap_device/runtime PM
> 
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> > This series makes I2C device registration use hwmod
> > and omap_device api's and converts the I2C driver to use
> > runtime PM api's.
> >
> > Patches apply on the pm-core branch from Kevin's tree.
> >
> > v2 has minor review comment fixes over v1 and is additionally
> > boot tested on a 2430sdp platform along with being tested on
> > 3430sdp and 4430sdp.
> >
> > 4430sdp tests are done using the below series
> > http://www.spinics.net/lists/linux-omap/msg36023.html
> 
> Hi Rajendra,
> 
> This series looks good to queue for 2.6.37.
> 
> Can you re-post one more time with linux-arm-kernel in CC as well as the
> I2C list and Ben Dooks (MAINAINERS excerpt below for addresses.)

Ok, thanks. Will do.

> 
> I will gladly merge patches 1-4, but I'll need an ack/signoff from Ben
> to merge patch 5.
> 
> Thanks,
> 
> Kevin
> 
> 
> I2C SUBSYSTEM
> M:	"Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
> M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
> L:	linux-i2c@vger.kernel.org
> 

