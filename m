From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 0/5] FIFO caused playback delay (latency) handling in
 soc/omap
Date: Fri, 12 Mar 2010 10:30:50 +0200
Message-ID: <20100312103050.b83db5c4.jhnikula@gmail.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100311222655.GP2900@atomide.com>
	<186E584F-F553-44F0-A49D-361BB76E0EE4@opensource.wolfsonmicro.com>
	<201003120818.30290.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:49647 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab0CLI3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 03:29:30 -0500
Received: by ewy20 with SMTP id 20so374465ewy.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 00:29:28 -0800 (PST)
In-Reply-To: <201003120818.30290.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>

On Fri, 12 Mar 2010 08:18:30 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> On Friday 12 March 2010 00:43:41 ext Mark Brown wrote:
> 
> > I can do, though there was some debate about how useful the
> > information the hardware returns actually is - could folks confirm
> > what the consensus there was, please?
> 
> Yeah, that thread went silent without final go or no go...
> 
...
> All in all, I think the usage of the BUFFSTAT register is a good compromise for 
> all cases, and it is needed for the cases, where the codec also have buffer of 
> it's own.
> 
And one point is that the BUFFSTAT use doesn't make things worse than
currently.  Now the application doesn't have any information about the
HW buffer caused audio latencies so reporting them makes the things
better than currently.


-- 
Jarkko
