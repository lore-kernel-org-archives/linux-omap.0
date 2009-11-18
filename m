From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 1/1] omap: serial: fix non-empty uart fifo read abort
Date: Wed, 18 Nov 2009 01:00:11 +0000
Message-ID: <20091118010011.22360590@lxorguk.ukuu.org.uk>
References: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42180 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753800AbZKRA6Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 19:58:16 -0500
In-Reply-To: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

On Tue, 17 Nov 2009 17:39:11 -0600
Vikram Pandita <vikram.pandita@ti.com> wrote:

> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.
> 
> Overrigt the default 8250 read handler: mem_serial_in()
> by a custom handler: serial_in_8250()
> 
> serial_in_8250() makes sure that RX fifo is not read when empty,
> on omap4 and 3630 silicons only
> 
> tested on zoom3(3630) board

Acked-by: Alan Cox <alan@linux.intel.com>

(Please push it via the OMAP tree as its now OMAP specific)


Alan
