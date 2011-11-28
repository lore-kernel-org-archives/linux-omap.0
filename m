From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 0/4] OMAP serial device tree support
Date: Mon, 28 Nov 2011 15:31:49 +0900
Message-ID: <20111128063149.GB15189@kroah.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com>
 <20111127033642.GA28378@kroah.com>
 <4ED32500.5060908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51388 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111Ab1K1GeX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 01:34:23 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 09CED20FEE
	for <linux-omap@vger.kernel.org>; Mon, 28 Nov 2011 01:34:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4ED32500.5060908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

On Mon, Nov 28, 2011 at 11:36:56AM +0530, Rajendra Nayak wrote:
> On Sunday 27 November 2011 09:06 AM, Greg KH wrote:
> >On Tue, Nov 22, 2011 at 07:14:12PM +0530, Rajendra Nayak wrote:
> >>v2 is based on the latest omap-serial runtime patches, which
> >>can be found here[1]
> >>
> >>The series passes minimal data that allows serial console
> >>boot, with UART's initialised from device tree.
> >>However some of low power support for UART and remote
> >>wakeup needs more work.
> >>Boot tested on OMAP4 panda and OMAP4 sdp boards.
> >>
> >>Patches can be found here..
> >>git://gitorious.org/omap-pm/linux.git for-dt/serial
> >
> >What tree are these going to go through, some device tree one, or do you
> >want me to take the serial driver patches?
> 
> Hi Greg,
> 
> These patches have a dependency on the omap-serial runtime series.
> So once that makes it in, through the serial driver tree, and once we
> have the necessary Acks from the Device Tree maintainers on the relevant
> patches from this series, these could go through the serial driver tree
> as well.

Then all of these should probably go through the device tree tree.

thanks,

greg k-h
