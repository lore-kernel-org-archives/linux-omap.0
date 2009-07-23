From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Boot Hang - mmotm 090716 - serial 8250 irq flags support
Date: Thu, 23 Jul 2009 15:46:57 +0100
Message-ID: <20090723154657.184a12ab@lxorguk.ukuu.org.uk>
References: <1248291948.4490.67.camel@useless.americas.hpqcorp.net>
	<20090723113353.7da8f6f9@lxorguk.ukuu.org.uk>
	<1248353462.5674.80.camel@useless.americas.hpqcorp.net>
	<20090723145754.3f001c4e@lxorguk.ukuu.org.uk>
	<FCCFB4CDC6E5564B9182F639FC35608702F57AD326@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48986 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752711AbZGWOqB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jul 2009 10:46:01 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F57AD326@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Lee Schermerhorn <Lee.Schermerhorn@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Eric Whitney <eric.whitney@hp.com>, Rich Freiss <richard.freiss@hp.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

> Are you referring to serial-add-irqflags-support patch.
> Do let me know in case any respin of this patch is needed.

The old_serial_port structure just needed the irqflags field moving to
the end so it didn't break some existing initialisers (eg
arch/x86/include/asm/serial.h)

Alan
