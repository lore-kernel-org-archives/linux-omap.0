From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 00:51:58 -0700
Message-ID: <20120607075158.GZ12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63957 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab2FGHwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 03:52:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

* Paul Walmsley <paul@pwsan.com> [120607 00:44]:
> On Thu, 7 Jun 2012, Tony Lindgren wrote:
> 
> > Here too I think driver like features like this should live in the
> > driver init for omap OHCI driver. In the likely case that FS OHCI is
> > not in use on the board, the OHCI glue can just reset it.
> 
> What if the driver is not compiled into the kernel, but instead is built 
> as a loadable module?

You can still have a core piece of the driver that's always built in, such
as omap-ohci-common. But it should live under drivers, not in the bus level
code. Or you can insmod/rmmod it to reset things properly.

Regards,

Tony
