From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Wed, 27 Aug 2008 09:38:49 +0300
Message-ID: <20080827093849.c047b6eb.jarkko.nikula@nokia.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	<5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	<20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	<5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	<20080826161938.4fc7e990.jarkko.nikula@nokia.com>
	<5e088bd90808261018h1e04cbd4o20e88669031eda4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38941 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbYH0GjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 02:39:13 -0400
In-Reply-To: <5e088bd90808261018h1e04cbd4o20e88669031eda4d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 26 Aug 2008 10:18:56 -0700
"ext Steve Sakoman" <sakoman@gmail.com> wrote:

> > Sounds indeed strange. Can you track is the pcm_file->substream
> > getting zeroed somewhere after it is set in snd_pcm_open_file? Like
> > printing both address of pcm_file and pcm_file->substream.
> 
> I don't believe that it is the SNDRV_PCM_IOCTL_START that writes a
> null in substream, so it is likely something in alsa-lib :-(
> 
One thing came to my mind that does your kernel and user space (E)ABI
match? I rememeber that there were some strange IOCTL related errors
with ALSA mixers if the kernel was compiled with CONFIG_EABI and
CONFIG_OABI_COMPAT but Debian was using legacy ABI.

> It isn't confidence inspiring to see comments like /* AB: FIXME!!!
> This is definitely nonsense */ in snd_pcm_info (the function where it
> finally crashes)
> 
Heh, that's true.


Jarkko
