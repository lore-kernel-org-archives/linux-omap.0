From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2] arm: omap: Add omap3_defconfig
Date: Tue, 1 Dec 2009 09:29:42 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA902176@dbde02.ent.ti.com>
References: <20091130033434.GA8762@lixom.net>
 <20091201031932.GA19917@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40935 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbZLAD7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 22:59:46 -0500
In-Reply-To: <20091201031932.GA19917@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Olof
<snip>
>+# CONFIG_OMAP_LL_DEBUG_UART1 is not set
>+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
>+CONFIG_OMAP_LL_DEBUG_UART3=y
>+# CONFIG_OMAP_LL_DEBUG_NONE is not set

I will suggest to keep LL_DEBUG_NONE as the default option and also disable the DEBUG_LL by default.
a) Not all omap boards have UART3 as the debug low level interface
b) Boards like zoom2/zoom3 have external uarts and should not define internal omap uart as Low level debug function.

>+# CONFIG_OMAP_PM_NONE is not set
>+CONFIG_OMAP_PM_NOOP=y
>+CONFIG_ARCH_OMAP34XX=y
>+CONFIG_ARCH_OMAP3430=y
