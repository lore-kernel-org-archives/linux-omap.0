From: Tony Lindgren <tony@atomide.com>
Subject: Re: DT support for OMAP3 ISP
Date: Tue, 6 Jan 2015 13:42:18 -0800
Message-ID: <20150106214218.GZ4081@atomide.com>
References: <CAK8F28mM1qwxaSJ4pdy2DC6+7sY-c_-yQGxDfYqi50B7SOBpdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12991 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932729AbbAFVqH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 16:46:07 -0500
Content-Disposition: inline
In-Reply-To: <CAK8F28mM1qwxaSJ4pdy2DC6+7sY-c_-yQGxDfYqi50B7SOBpdQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ash Charles <ashcharles@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi

* Ash Charles <ashcharles@gmail.com> [150106 12:45]:
> Hi,
> 
> I'm playing with the Caspa camera (mt9v032) and Overo on the 3.17
> kernel.  It looks like there has been some work on dt-bindings for the
> omap3isp (notably [1] and [2]) but I didn't see anything heading for
> mainline.
> 
> What would be needed to support cameras using the omap3isp in a mainline kernel?

No idea about the camera, but at least the legacy omap DMA calls need
to be replaced or removed as the legacy DMA API will go away soon.

For the media code, these can be viewed with:

$ git grep omap_request_dma drivers/media/

Regards,

Tony
 
> [1] https://github.com/vaussard/linux/commits/overo-for-3.14/iommu/dt-v2
> [2] http://git.linuxtv.org/cgit.cgi/sailus/media_tree.git/log/?h=rm696-043-dt
