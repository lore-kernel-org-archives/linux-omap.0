From: Kevin Hilman <khilman@ti.com>
Subject: Re: omap_device prints
Date: Thu, 21 Jul 2011 07:57:00 -0700
Message-ID: <87mxg7d6mb.fsf@ti.com>
References: <20110721095109.GC28942@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43386 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041Ab1GUO5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 10:57:05 -0400
Received: by mail-iy0-f181.google.com with SMTP id 40so1074432iyf.12
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 07:57:02 -0700 (PDT)
In-Reply-To: <20110721095109.GC28942@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 21 Jul 2011 10:51:09 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> I spotted this while booting the OMAP4430 SDP:
>
> omap_device: omap4-keypad.-1: new worst case activate latency 0: 61035
>

[...]

> Is there something wrong with dev_name(&od->pdev.dev) so that we have
> consistent naming of devices, rather than poking about inside the
> platform_device accessing the name initializers directly ?

I've been meaning to convert most of these from pr_debug() to dev_dbg().

There are a few that have to remain pr_debug() because they are used
before the platform_device (and struct device) are initialized, but most
of them can be converted.

Patch coming shortly.

Kevin
