From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Wed, 2 May 2012 02:45:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205020242420.19695@utopia.booyaka.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com> <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com> <1335173044.2149.64.camel@sokoban> <87obqhawig.fsf@ti.com> <1335532591.2149.163.camel@sokoban> <87fwbowyuu.fsf@ti.com> <1335790016.2149.185.camel@sokoban> <87vckht0lf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57544 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab2EBIpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 04:45:35 -0400
In-Reply-To: <87vckht0lf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Kevin,

> Afzal, care to give this one a test as well?  It should have the same
> result but is a more targetted fix.  With and ack from Tero and a
> Tested-by from you, I'll post this to the list and and queue it up for
> v3.5.

just checking on this one to discuss how we should handle the 
io_chain_devel_3.5 branch on my git tree, which would depend on this 
patch... this is a tricky series since it touches PM, PRM, and hwmod 
code...


- Paul
