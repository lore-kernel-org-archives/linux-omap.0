From: Gregory CLEMENT <gclement00@gmail.com>
Subject: Re: [PATCH RFC 0/5] usb: ohci: introduce ohci-hcd driver for omap3
Date: Wed, 24 Mar 2010 08:17:42 +0000 (UTC)
Message-ID: <loom.20100324T090528-470@post.gmane.org>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41217 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953Ab0CXIUE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Mar 2010 04:20:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1NuLoo-0006Tj-Vt
	for linux-omap@vger.kernel.org; Wed, 24 Mar 2010 09:20:03 +0100
Received: from 64-218-144-213.altitudetelecom.fr ([64-218-144-213.altitudetelecom.fr])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 09:20:02 +0100
Received: from gclement00 by 64-218-144-213.altitudetelecom.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 09:20:02 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Anand Gadiyar <gadiyar <at> ti.com> writes:

> 
> Hi all,

Hi Anand,

> 
> (Apologies if you get this twice - I sent this out 24 hours ago,
> and it still hasn't reached the lists. So resending).
> 
> This patch series adds the bus glue layer for the OHCI controller
> on OMAP3 and later chips. This controller is a companion
> to the EHCI controller on that IP, and some code is common
> across the drivers. The driver has been sitting in internal
> trees for ages, and I've finally found time to clean it up
> and submit it.

This is a good news, one or two month ago we were looking for such a patch!
Finally we take an old version that we adapt to just make it works. Our future
plan was to clean it up and submit a correct version. As your version seems more
advanced,we will take it and test it for our board. I hope be able to feed
information by the end of the week.

> The older OMAP1 and OMAP2 chips had a different OHCI controller,
> which already has driver support in mainline. I don't have access
> to this and haven't tested the driver on those boards.
> (Also, I made some updates to Kconfig, and have not yet updated the
> defconfigs for those omap1/2 boards. I'll update them if the Kconfig
> changes are okay)
> 
> This controller supports multiple interface modes. Only 2 of them
> (3-pin DAT/SE0 and 4-pin DP/DM PHY modes) have been tested with this
> driver. (However the only change for the other modes is one register
> setting for selecting the mode, and the padconf setting for the omap
> pads), so I expect it to work correctly with this version.
> 
> If anyone has OMAP3 boards with an OHCI controller, please test.

Our board use the 6-pin DP/DM PHY mode, so it will be a new mode to be validated

> 
> Thanks,
> Anand

-- 
Gregory CLEMENT
Embedded Linux Development Lead - EMEA
Adeneo Embedded - Adetel Group



