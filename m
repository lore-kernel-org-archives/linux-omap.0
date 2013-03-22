From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 10:07:34 +0100
Message-ID: <514C1F56.7080403@gmail.com>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <514C1C78.3090702@gmail.com> <alpine.DEB.2.01.1303220958040.7975@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34289 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373Ab3CVJHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Mar 2013 05:07:35 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq4so4042939wib.17
        for <linux-omap@vger.kernel.org>; Fri, 22 Mar 2013 02:07:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.01.1303220958040.7975@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 22.03.2013 10:03, Peter Meerwald wrote:
> 
>>> I'm running Linux 3.7 on a beagle-xm and observe very reproducible stereo 
>>> channel swapping issue on playback of a stereo stream (one channel has a 
>>> sine, the other is zero); the channel swap occurs on starting the playback
> 
>> Always? Or in like 50% of the runs? And is the record stream (IOW: the
>> clocks) already running when you switch on playback?
> 
> in 10 runs, the swap can maybe observed 3 times; so: not always
> 
> I can easily turn on/off the clock for the McBSP3/TLV320AIC3104 setup; 
> with McBSP3 being master I ONLY have the issue when the clock is already 
> running; when I start the stream first, then turn on the clock, there is 
> NO SWAP

Yes, that sounds familiar. I guess the problem is that the serial line
driver does not respect a specific slope (like lo->hi) but will sync up
to *any* slope once it gets its enable bit set. Which will give you
arbitrary channel swaps.


Daniel

