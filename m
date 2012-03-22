From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Wed, 21 Mar 2012 18:15:27 -0700
Message-ID: <CA+Bv8Xa7=0yLGH6Pfz4hi5ByQ-SCdX-tctMnRMYYthrjM5ZOog@mail.gmail.com>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk>
	<20120317004706.GF7276@atomide.com>
	<20120317211505.GA4720@n2100.arm.linux.org.uk>
	<1332149601.2144.15.camel@deskari>
	<20120319123006.GC16389@n2100.arm.linux.org.uk>
	<1332160864.2144.66.camel@deskari>
	<1332162163.2144.77.camel@deskari>
	<1332165550.2144.85.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47517 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab2CVBP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 21:15:28 -0400
Received: by pbcun15 with SMTP id un15so1175578pbc.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 18:15:28 -0700 (PDT)
In-Reply-To: <1332165550.2144.85.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Mar 19, 2012 at 6:59 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-03-19 at 15:02 +0200, Tomi Valkeinen wrote:
>
>> I'll see if I can make a single patch that fixes the issue. The patch
>> series I mentioned earlier does lots of things, but I think just moving
>> the driver registration out of the probe function should be enough to
>> avoid the problem.
>
> Here's a patch that fixes the issue for me. Tested on OMAP4 Blaze with
> omapdss both as module and built-in. I'll queue this up after testing it
> a bit more.
>
> This still leaves the issue of initialization order, but I think that's
> not a big issue at the moment. It doesn't happen in practice, as the
> current driver framework will probe the devices at driver registration
> time. I'll fix this for the next merge window.

I bisected a boot failure on an am37x-evm to 3ec2decb commit as well.
This fixes it for me too.
