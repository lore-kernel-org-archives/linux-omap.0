From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: OMAP5912 AIC23
Date: Mon, 25 Aug 2008 20:56:13 -0500
Message-ID: <48B362BD.10009@css-design.us>
References: <65e025470808251004w109cece7t9caeaa81b422554b@mail.gmail.com> <65e025470808251011j42564e2g7a445558f9e82559@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:42958 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757053AbYHZB4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Aug 2008 21:56:15 -0400
In-Reply-To: <65e025470808251011j42564e2g7a445558f9e82559@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yuri Jaeger Monti <yurijm@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Yuri,

We have had good luck with ARM audio under this setup.  We did write our 
own AIC23 drivers which we used directly from our application.  We used 
a device entry (/dev/aic23) that hooked in our driver.  We were able to 
open those in any application and play/record or both.  The only 
possible problem was if we tried to do things like "cat file.pcm > 
/dev/aic23".  Although this would work, some cases would not work due to 
those applications buffering schemes.  For example, this was bad:  "cat 
/dev/aic23 > /dev/aic23".   It would work, but would be choppy. 

How are you playing audio?

Steve

Yuri Jaeger Monti wrote:
> Hi fellows,
>
> I tried everything I could to solve the buffer underrun error's while
> playing some audio in the OSK5912 with the AIC23, and I don't know
> what should I do anymore.
> I'm trying to simply output and audio file via the ARM, I think this
> should be ok but the audio is always choppy.
> Am I doing something wrong? Or perhaps should I use only the DSP
> processor to play the audio? (didn't tried this yet because I need the
> DSP to do other tasks).
>
> Cheers
>
> ---
> Yuri Jaeger Monti
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

