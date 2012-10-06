From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 20/24] SERIAL: core: add xmit buffer allocation callbacks
Date: Sat, 6 Oct 2012 16:49:56 +0100
Message-ID: <20121006164956.2956375c@pyramind.ukuu.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
	<E1TKTlL-0002ni-MB@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57748 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2JFPpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 11:45:38 -0400
In-Reply-To: <E1TKTlL-0002ni-MB@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, 06 Oct 2012 13:45:47 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> This allows drivers (such as OMAP serial) to allocate and free their
> transmit buffers in a sane manner, rather than working around the
> buffer allocation provided by serial_core.

I think this just illustrates how broken the serial_core layering is in
that drivers can't treat it as a library but get constrained by it.

Fine for now and actually probably a useful hook to begin removing the
circ buffers for the kernel generic kfifo and other work that needs doing
eventually.

Alan
