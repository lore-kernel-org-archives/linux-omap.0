From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: LDP support
Date: Sun, 31 May 2009 19:24:19 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038DEAB716@dlee02.ent.ti.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk>
 <20090428224237.GT22457@atomide.com>
 <20090531212449.GD25140@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33835 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbZFAAYj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 May 2009 20:24:39 -0400
In-Reply-To: <20090531212449.GD25140@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

> 6. do ___NOT___ (underscored in triplicate and 500ft high letters) enable
>    ARM errata 460075 - it solidly prevents the kernel booting on LDP.
>    (it's taken many hours to debug that.)

This is an r2p0 errata only.  It's not in earlier versions or in later cores.

Today there are only r1pX OMAP3s today.  In the future there will be r3px also.

Regards,
Regards,
Richard W.
