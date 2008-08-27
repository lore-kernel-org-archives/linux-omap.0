From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Wed, 27 Aug 2008 06:39:06 -0700
Message-ID: <5e088bd90808270639o1d0ba027r4d6ed9683d68fea2@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080826161938.4fc7e990.jarkko.nikula@nokia.com>
	 <5e088bd90808261018h1e04cbd4o20e88669031eda4d@mail.gmail.com>
	 <20080827093849.c047b6eb.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:48746 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbYH0NjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 09:39:08 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1338979yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 06:39:07 -0700 (PDT)
In-Reply-To: <20080827093849.c047b6eb.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> One thing came to my mind that does your kernel and user space (E)ABI
> match? I rememeber that there were some strange IOCTL related errors
> with ALSA mixers if the kernel was compiled with CONFIG_EABI and
> CONFIG_OABI_COMPAT but Debian was using legacy ABI.

Both kernel and user space are EABI.

I received some new hw to bring up yesterday, so I wasn't able to get
much further on debugging this.  But I did verify that running
'mplayer song.mp3' first before using  'mplayer -ao alsa song.mp3'
resulted in an ioctl trace where substream did *not* go NULL after the
START ioctl.  Very strange!

Hope to get back to it later today if I can finish bringing up the new hw.

Steve
