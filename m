From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Soft lockups with 2.6.29-rc3 when using ASoC?
Date: Sun, 1 Feb 2009 10:41:19 +0200
Message-ID: <20090201104119.9346796a.jhnikula@gmail.com>
References: <5e088bd90901310651o59b31a80yda2d2e51c9074679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:15893 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbZBAIje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Feb 2009 03:39:34 -0500
Received: by fg-out-1718.google.com with SMTP id 16so344454fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 01 Feb 2009 00:39:32 -0800 (PST)
In-Reply-To: <5e088bd90901310651o59b31a80yda2d2e51c9074679@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Sat, 31 Jan 2009 06:51:45 -0800
Steve Sakoman <sakoman@gmail.com> wrote:

> I did a quick test of 2.6.29-rc3.  Things looked pretty good till I
> tried mplayer.
> 
> There was a one minute hang (no sound), then a set of soft lockup
> messages:
> 
..
> I do not see this issue with 2.6.29-rc2
> (675e66d8261d3327bc467426f8a7e15ec8ffad2c) and the identical patch
> set.
> 
I'm pretty sure 2.6.29-rc3 will work if you apply this patch from
mainline

commit ef390c0b6e3f4d2d2d43f53f4bd35e1884571a14
Author: Misael Lopez Cruz <x0052729@ti.com>
Date:   Thu Jan 29 13:29:46 2009 +0200

    ASoC: OMAP: Initialize XCCR and RCCR registers in McBSP DAI driver

2.6.29-rc2 was working because Tony reverted temporary the counterpart
commit writing those registers and now it came back from mainline. Bit
hassle but hopefully will work ok after Tony's next pull. But mainline
is ok :-)


-- 
Jarkko
