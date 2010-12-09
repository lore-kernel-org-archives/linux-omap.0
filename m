From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Thu, 09 Dec 2010 15:46:13 -0800
Message-ID: <8739q65x2y.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
	<4CFE9059.1080202@nokia.com>
	<AANLkTimKCBm0+NTgJWvyivBqv0DoQhwMbsU2uxruoDot@mail.gmail.com>
	<alpine.DEB.2.00.1012071548490.13430@utopia.booyaka.com>
	<87zkseal9c.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1012091118550.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53657 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab0LIXqS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 18:46:18 -0500
Received: by yxt3 with SMTP id 3so1727906yxt.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 15:46:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012091118550.13430@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 9 Dec 2010 11:22:00 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sawant@ti.com" <sawant@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin
>
> On Thu, 9 Dec 2010, Kevin Hilman wrote:
>
>> Paul, do you want to submit a formal patch for this for 2.6.38? if not,
>> I can add a changelog and queue this with other PM core changes for 2.6.38.
>
> we should probably come up with a patch for .38 that only increments this 
> when off-mode is entered... otherwise there will probably be a performance 
> hit when off-mode-supporting devices are reinitialized after every 
> clk_enable() :-)  The HSMMC driver also resets the IP block when that 
> happens.

I have a series for this (will post shortly), but it only works for
omap_devices, since otherwise it's rather hacky to find the powerdomain
for a given device.

Unfortunately, MMC is still not converted to omap_device/omap_hwmod, so
my series doesn't help for MMC. :(

Kevin
