From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Tue, 26 Aug 2008 16:19:37 +0300
Message-ID: <20080826161938.4fc7e990.jarkko.nikula@nokia.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	<5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	<20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	<5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62211 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbYHZNxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 09:53:21 -0400
In-Reply-To: <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 25 Aug 2008 12:19:16 -0700
"ext Steve Sakoman" <sakoman@gmail.com> wrote:

> If I run 'mplayer -ao alsa song.mp3' immediately after booting I get a
> crash due to a null substream pointer (output below).
> 
> However if I run 'mplayer song.mp3' *before* 'mplayer -ao alsa
> song.mp3' then the latter command works!
> 
Sounds indeed strange. Can you track is the pcm_file->substream getting
zeroed somewhere after it is set in snd_pcm_open_file? Like printing
both address of pcm_file and pcm_file->substream.

I don't know, can we still have some instabilities with OMAP3 and
latest 2.6.27-rcx?


Jarkko
