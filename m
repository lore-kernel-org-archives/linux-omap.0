From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 11:11:42 +0100
Message-ID: <514C2E5E.2040909@gmail.com>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <alpine.DEB.2.01.1303221023070.7975@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:60285 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633Ab3CVKLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Mar 2013 06:11:43 -0400
Received: by mail-we0-f173.google.com with SMTP id x51so3016433wey.4
        for <linux-omap@vger.kernel.org>; Fri, 22 Mar 2013 03:11:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.01.1303221023070.7975@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 22.03.2013 10:56, Peter Meerwald wrote:
> 
>> I'm running Linux 3.7 on a beagle-xm and observe very reproducible stereo 
>> channel swapping issue on playback of a stereo stream (one channel has a 
>> sine, the other is zero); the channel swap occurs on starting the playback
> 
>> it appears that the swapping issue is back, probably due to the DMA rework 
>> in recent kernel?
> 
> kernel 3.4 does not have the issue

Well, then, I guess, you'll have to bisect it down.


Daniel

