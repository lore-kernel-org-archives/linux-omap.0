From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 09:20:24 +0000
Message-ID: <20130131092024.GN2637@n2100.arm.linux.org.uk>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk> <20130131030203.GA8374@quad.lixom.net> <alpine.LFD.2.02.1301302312030.6300@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59783 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab3AaJUh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 04:20:37 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1301302312030.6300@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, arm@kernel.org

On Wed, Jan 30, 2013 at 11:19:40PM -0500, Nicolas Pitre wrote:
> Better yet (IMHO): just enable the zboot command in U-Boot to let you 
> boot a zImage binary directly.

I wish it were that easy but it isn't.  I've no idea where to get a
version of uboot for my boards which supports that; TI have always
supplied updates to uboot for me, and with the current state of TI
being afaict in chaos.

TI have always supplied a replacement X-Loader with each uboot update.
I've no idea what X-Loader is or why both get updated together, but...

Moreover, I doubt that the 3430LDP, of which there are multiple versions,
will ever see a uboot update.  It already suffers from a lack of correct
kernel support due to random wiring changes between these versions (the
keypad doesn't work correctly) and I've yet to indentify which version
it is despite downloading the circuits.  So trying to locate the right
uboot will be impossible there.

So, I'm _stuck_ with uImages for these platforms.
