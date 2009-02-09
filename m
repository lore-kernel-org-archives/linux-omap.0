From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: musb OTG broken in 2.6.29-rc3?
Date: Mon, 9 Feb 2009 22:14:30 +0200
Message-ID: <20090209221430.b9c72229.jhnikula@gmail.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:39961 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbZBIUMR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 15:12:17 -0500
Received: by ewy14 with SMTP id 14so2757809ewy.13
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2009 12:12:16 -0800 (PST)
In-Reply-To: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Mon, 9 Feb 2009 09:40:57 -0800
Steve Sakoman <sakoman@gmail.com> wrote:

> In 2.6.29-rc3 I don't get any joy - the musb port doesn't seem to
> switch into host mode when I plug in a miniA cable. Booting with the
> miniA cable in place doesn't seem to help.  Compiling the kernel with
> host mode enabled works as expected.
> 
> Before I spend too much time debugging, has anyone else been
> successful with musb OTG in 2.6.29-rc3?  A quick search of this list
> didn't turn up any discussion of issues.
> 
N810 is working fine in both modes. Either as an ethernet gadget for PC
or detecting hub connected into it. Both when booting or during runtime.

I don't have Beagle now to verify but probably this helps a little to
hunt.


Jarkko
