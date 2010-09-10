From: Felipe Balbi <balbi@ti.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Fri, 10 Sep 2010 20:00:53 +0300
Message-ID: <20100910170053.GB2230@legolas.emea.dhcp.ti.com>
References: <20100910174814.6e5d439e@surf>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34293 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755078Ab0IJRA7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Sep 2010 13:00:59 -0400
Content-Disposition: inline
In-Reply-To: <20100910174814.6e5d439e@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Sep 10, 2010 at 10:48:14AM -0500, Thomas Petazzoni wrote:
>I also have a problem with USB support, both on linux-omap and Kevin's
>pm-core branch. My USB Ethernet adapter, supported by the asix driver,
>isn't detected anymore. With a pm git tree of a couple of weeks ago, it
>was working. This is again with just a plain omap3_defconfig.

is it attached to EHCI/OHCI or musb port ?

-- 
balbi
