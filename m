From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Boot Hang - mmotm 090716 - serial 8250 irq flags support
Date: Thu, 23 Jul 2009 20:06:01 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F57AD326@dbde02.ent.ti.com>
References: <1248291948.4490.67.camel@useless.americas.hpqcorp.net>
	<20090723113353.7da8f6f9@lxorguk.ukuu.org.uk>
	<1248353462.5674.80.camel@useless.americas.hpqcorp.net>
 <20090723145754.3f001c4e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbZGWOg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jul 2009 10:36:27 -0400
In-Reply-To: <20090723145754.3f001c4e@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Eric Whitney <eric.whitney@hp.com>, Rich Freiss <richard.freiss@hp.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

Alan

>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Sent: Thursday, July 23, 2009 8:58 AM
>To: Lee Schermerhorn
>Cc: Andrew Morton; Pandita, Vikram; Alan Cox; linux-kernel; Bjorn Helgaas; Eric Whitney; Rich Freiss
>
>> </system1>hpiLO-> Virtual Serial Port active: IO=0x02F8 INT=3
>>
>> Perhaps Bjorn or Rich could comment on the hardware setup...
>
>Ok thats a generic ISA port
>
>The rest fits the patch I sent you so hopefully that fixes it and if so
>I'll make sure the corrected one ends up in -next.

Are you referring to serial-add-irqflags-support patch.
Do let me know in case any respin of this patch is needed.

>
>Alan

