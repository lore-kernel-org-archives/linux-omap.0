From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP
 block
Date: Sat, 21 Jan 2012 07:55:22 -0500
Message-ID: <20120121125522.GA19027@kroah.com>
References: <20120121071934.18707.64258.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58334 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751484Ab2AUM4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Jan 2012 07:56:43 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1D2B520BB3
	for <linux-omap@vger.kernel.org>; Sat, 21 Jan 2012 07:56:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120121071934.18707.64258.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj Raja <govindraj.r@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, alan@linux.intel.com

On Sat, Jan 21, 2012 at 12:27:37AM -0700, Paul Walmsley wrote:
> [ This series is targeted for merging during v3.3-rc ]
> 
> On v3.3-rc1, the OMAP serial console doesn't behave properly when
> power management is enabled (the default with omap2plus_defconfig).
> This seems to be due to a combination of a silicon bug in the UART IP
> block and broken FIFO settings in the OMAP serial driver.
> 
> This patch series attempts to work around these problems.  The workarounds
> are not perfect; see the patch descriptions for more details.
> 
> Tested on OMAP3530 BeagleBoard.  This series will need to be tested on
> OMAP2 and OMAP4 before it is ready to merge.

Who is going to do that testing?  When?  Why isn't it done already?

I guess this means I can ignore them for now, right?

greg k-h
