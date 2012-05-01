From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Tue, 1 May 2012 12:55:25 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E97C988@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	<alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	<1335173044.2149.64.camel@sokoban> <87obqhawig.fsf@ti.com>
	<1335532591.2149.163.camel@sokoban> <87fwbowyuu.fsf@ti.com>
	<1335790016.2149.185.camel@sokoban> <87vckht0lf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32917 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab2EAMzc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 08:55:32 -0400
In-Reply-To: <87vckht0lf.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Kristo, Tero" <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

On Tue, May 01, 2012 at 02:10:28, Hilman, Kevin wrote:
> 
> Afzal, care to give this one a test as well?  It should have the same
> result but is a more targetted fix.  With and ack from Tero and a
> Tested-by from you, I'll post this to the list and and queue it up for
> v3.5.

Over what commit id, should this patch be applied ?, unable to apply it over
"297624c ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle", the
one that I tested your previous patch.

Regards
Afzal


> 
> From 274ded7fbe573bbbe45db80bdc1989272077c011 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Fri, 27 Apr 2012 16:05:51 -0700
> Subject: [PATCH] ARM: OMAP3: PM: leave PRCM interrupts disabled until
>  explicitly enabled.
