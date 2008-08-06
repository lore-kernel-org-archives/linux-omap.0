From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Problems with USB Gadget on the OMAP3EVM
Date: Wed, 6 Aug 2008 10:31:37 +0300
Message-ID: <20080806073136.GA20588@frodo>
References: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com> <20080805112736.GZ30539@gandalf.research.nokia.com> <ece1079f0808052212r6f4b2830i2ace5e66263998dd@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48325 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbYHFHtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 03:49:42 -0400
Content-Disposition: inline
In-Reply-To: <ece1079f0808052212r6f4b2830i2ace5e66263998dd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kanagesh radhakrishnan <rkanagesh@gmail.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Wed, Aug 06, 2008 at 10:42:40AM +0530, kanagesh radhakrishnan wrote:
> The version of Linux kernel on the native host Fedora Core 5 machine
> is the default 2.6.9-1.667 kernel that comes with the FC5 release.
> Keeping in mind where we are, this does sound like an ancient kernel.
> However, I have USB networking with Gadget drivers working on this
> same machine with OMAP5912 OSK, OMAP2430 SDP and another custom
> OMAP2430 based board.
> 
> Nevertheless, I decided to upgrade to a more recent version of the
> Linux kernel on the host system.  I will test the setup once again and
> update the observation.

Cool, would be nice to try current linux-omap git tree as well for your
omap3emv board :-)

> Meanwhile, I tested the setup with a Windows XP host machine and these
> are the observations:
> On insertion of the USB cable to the Win XP host machine, the OMAP3EVM
> board gets detected as 'RNDIS/Ethernet' Device.  I go through the
> driver installation (driver used is file Documentation/usb/linux.inf
> from the standard Linux kernel sources).  After the installation is
> complete, I get an error from the Windows XP system saying "An error
> was encountered while installing the driver and the hardware might not
> function as intended"

Did you give usb0 an ip on the gadget side ?

-- 
balbi
