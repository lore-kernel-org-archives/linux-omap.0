From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Fri, 6 Apr 2012 07:52:37 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
 <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54496 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab2DFHwm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 03:52:42 -0400
In-Reply-To: <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Fri, Apr 06, 2012 at 12:43:06, Paul Walmsley wrote:
> Perhaps you might be willing to add some debugging to omap_mux_late_init() 
> to find out what part of that function is causing it to hang?

It is getting hung as interrupt handler "omap_hwmod_mux_handle_irq"
is being repeatedly called.

Regards
Afzal
