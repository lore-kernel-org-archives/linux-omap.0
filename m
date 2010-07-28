From: Tomi Valkeinen <tomi.valkeinen@Nokia.com>
Subject: Re: OMAP2 DSS Linux Driver
Date: Wed, 28 Jul 2010 13:32:03 +0300
Message-ID: <1280313123.2427.109.camel@tubuntu.research.nokia.com>
References: <4C4FF08D.4040503@mpcdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48789 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab0G1KcU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 06:32:20 -0400
In-Reply-To: <4C4FF08D.4040503@mpcdata.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nicholas Beck <nbeck@mpcdata.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-07-28 at 10:55 +0200, ext Nicholas Beck wrote:
> Hi Tomi,
> 
> Firstly, I apologise if you would prefer this on a maillist rather than 
> a direct mail. Please let me know if you would prefer this on a maillist 
> I will post it there instead.

cc'ing linux-omap mailing list is always good (cc'd). More people can
answer, and more people will see the answer.

> I am working with the omap2 DSS driver implementation that you created. 
> The DSS linux docs say that MIPI DBI (RFBI) output is working and tested.
> 
> Please could you let me know what platform you tried this on?

That information is a bit outdated. RFBI was working and tested, and the
platform was Nokia N800. However, the panel driver for N800 was just a
quickly ported hack, and currently there are no public boards that use
DSS2 and RFBI.

There has been quite big changes in the DSS2 code, and RFBI is most
likely broken. There has also been some discussions about RFBI in
linux-omap mailinglist, but I haven't looked at the RFBI code myself as
I don't have any board to test it on.

> I am working with some custom hardware, which is largely similar to the 
> OMAP3530EVM, but will use MIPI DBI (RFBI) through a custom FPGA instead 
> of MIPI DPI (RFBI bypass) as used by the EVM's LCD. We are trying to 
> reduce the integration risk by basing this work on a known working platform.

Most likely the problems with RFBI are quite small, as the driver did
work earlier. However, finding those small problems may be a big job =).
I suggest you search l-o mailing list archives, and try to work with the
guys there who are trying to use RFBI.

 Tomi


