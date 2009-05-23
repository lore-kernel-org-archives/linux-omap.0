From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Status of clock patches after mainline reset? Case: Beagle C2
 and EHCI
Date: Sat, 23 May 2009 00:57:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905230051270.26015@utopia.booyaka.com>
References: <20090522092016.5e4a7da7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44738 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZEWG5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 02:57:18 -0400
In-Reply-To: <20090522092016.5e4a7da7.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Jarkko

On Fri, 22 May 2009, Jarkko Nikula wrote:

> EHCI port is not working on my Beagle C2 with linux-omap but is working
> with this one:
> 
> http://www.angstrom-distribution.org/demo/beagleboard/uImage-2.6.28-r17-beagleboard.bin
> 
> Looks like the error below was fixed by the
> 205f37af718984ec67444bccc888cd575531bce1 but got reseted with Tony's
> eba05254cb561dc27d5664503f91f7c21954e648.
> 
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Drive
> Clock usbhost_48m_fck didn't enable in 100000 tries
> ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
>
> Is this re-fixed with your last week set, in PM branch etc?

Unfortunately, no.  Looking at the patches, this seems to have been one 
of the upstream clock merge casualties.

I will try to get a fix series out soon for 2.6.30-rcX for this.

Thanks for the detailed bug report -

- Paul
