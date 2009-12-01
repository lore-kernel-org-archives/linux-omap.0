From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] arm: omap: Add omap3_defconfig
Date: Mon, 30 Nov 2009 22:13:27 -0600
Message-ID: <20091201041327.GA20316@lixom.net>
References: <20091130033434.GA8762@lixom.net> <20091201031932.GA19917@lixom.net> <FCCFB4CDC6E5564B9182F639FC35608702FA902176@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:41003 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbZLAELd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 23:11:33 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA902176@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>

On Tue, Dec 01, 2009 at 09:29:42AM +0530, Pandita, Vikram wrote:
> 
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Olof
> <snip>
> >+# CONFIG_OMAP_LL_DEBUG_UART1 is not set
> >+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
> >+CONFIG_OMAP_LL_DEBUG_UART3=y
> >+# CONFIG_OMAP_LL_DEBUG_NONE is not set
> 
> I will suggest to keep LL_DEBUG_NONE as the default option and also disable the DEBUG_LL by default.

Yeah, good point.

However:

> a) Not all omap boards have UART3 as the debug low level interface

Correct.

> b) Boards like zoom2/zoom3 have external uarts and should not define internal omap uart as Low level debug function.

Actually, the only way to get DEBUG_LL output out of a zoom2/3 right
now is to use S2-1=ON and OMAP_LL_DEBUG_UART3 output on J13...

Anyway, changing it makes sense, will repost tomorrow.


-Olof
