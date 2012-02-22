From: Kevin Hilman <khilman@ti.com>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Wed, 22 Feb 2012 14:00:24 -0800
Message-ID: <874nuizfyf.fsf@ti.com>
References: <4F3E0EB7.9060803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42828 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755387Ab2BVWAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 17:00:13 -0500
Received: by mail-pw0-f42.google.com with SMTP id wz12so715562pbc.29
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 14:00:12 -0800 (PST)
In-Reply-To: <4F3E0EB7.9060803@ti.com> (Peter Ujfalusi's message of "Fri, 17
	Feb 2012 10:24:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> Hi,
>
> I hoped that time will solve this, but so far no luck. I just can not
> get the ethernet port (along with the USB host ports) working on my xM RevC.
> What is the trick to get it working on 3.3-rc3?
>
> There seams to be some configuration issue:
>
> [    1.437530] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.444671] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
> [    1.451354] ehci-omap ehci-omap.0: failed to get ehci port0 regulator
> [    1.458282] ehci-omap ehci-omap.0: failed to get ehci port1 regulator


The first thing I try when I see these regulator failures is to add
CONFIG_REGULATOR_DUMMY=y to the .config to see if that helps.  If so,
then the board file needs some help configuring the right regulators.

Kevin
