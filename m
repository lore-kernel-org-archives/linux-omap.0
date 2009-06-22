From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: add IRQ trigger support
Date: Mon, 22 Jun 2009 14:24:02 +0100
Message-ID: <20090622142402.5e36e7fd@lxorguk.ukuu.org.uk>
References: <1244827971-14981-1-git-send-email-vikram.pandita@ti.com>
	<20090612213127.0f03e0c5@taxman.wild-wind.fr.eu.org>
	<20090622124037.GD7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33073 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753021AbZFVNWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 09:22:52 -0400
In-Reply-To: <20090622124037.GD7352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <maz@misterjones.org>, Vikram Pandita <vikram.pandita@ti.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

> To me it sounds like the it would be better to have unsigned
> long irqflags in struct uart_port instead of trying to squeeze
> the irqflags the flags field. We're already not covering all the
> irqflags currently like Marc pointed out.

Agreed.

Alan
