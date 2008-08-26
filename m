From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Tue, 26 Aug 2008 07:23:41 -0700
Message-ID: <5e088bd90808260723l43bb410v2d38df33c148c901@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080826161938.4fc7e990.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:62709 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbYHZOXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 10:23:42 -0400
Received: by wa-out-1112.google.com with SMTP id j37so907018waf.23
        for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 07:23:41 -0700 (PDT)
In-Reply-To: <20080826161938.4fc7e990.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Sounds indeed strange. Can you track is the pcm_file->substream getting
> zeroed somewhere after it is set in snd_pcm_open_file? Like printing
> both address of pcm_file and pcm_file->substream.
>
> I don't know, can we still have some instabilities with OMAP3 and
> latest 2.6.27-rcx?

That is my suspicion also.

I have tracked things through the exit of snd_pcm_open_file and found
the substream pointer to be valid to that point.

The null substream pointer seems to be coming in to a
snd_pcm_playback_ioctl call that occurs after the file open (I suspect
from a
call to snd_pcm_hw_info in alsa-lib)

Looks like I need to start adding debug printf's in alsa-lib too.  I'm
working on this as a background task while bringing up some new hw so
progress is a bit slow :-(

Steve
