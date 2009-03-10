From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2] OMAP: McBSP: Always maintain McBSP fclk while
 active
Date: Tue, 10 Mar 2009 16:29:54 +0200
Message-ID: <20090310162954.c3876442.jarkko.nikula@nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
	<12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19783 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbZCJOaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 10:30:21 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2AERmEl008770
	for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2009 09:30:18 -0500
In-Reply-To: <12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 9 Mar 2009 08:05:11 +0100
"Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
wrote:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> McBSP fclk must be maintained for the duration of
> audio playback or recording. Otherwise the fclk
> may get autogated when the PER96M clk is no longer
> required by other modules. This results in audio
> playback being hang. Fix this phenomenom by 
> enabling the McBSP fclk clockactivity bit for
> the entire active duration of McBSP usage
> 
...
>  		w = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
> -		w &= ~(ENAWAKEUP | SIDLEMODE(0x03));
> -		w |= (ENAWAKEUP | SIDLEMODE(0x02));
> +		w &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY
> (0x03));
> +		w |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY
> (0x01)); OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, w);
>  
Looks like a valid change eventhough haven't tested the actual problem.
Would it be possible with the PM branch and Beagle now?


Jarkko
