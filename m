From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Overo broken after recent mainline merge
Date: Sun, 15 Mar 2009 15:32:51 -0700
Message-ID: <5e088bd90903151532o15a0eb54pdc7d3a2563f4cf4d@mail.gmail.com>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com>
	 <200903141208.30413.david-b@pacbell.net>
	 <5e088bd90903141647s2faee448s6472f6b7bb9e0ba4@mail.gmail.com>
	 <200903141900.08727.david-b@pacbell.net>
	 <5e088bd90903151256v554ee5edwbf36d2ebc29add03@mail.gmail.com>
	 <5e088bd90903151515g25ccb614q6537c5c64ee81cbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:36298 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbZCOWcx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 18:32:53 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1277546rvb.1
        for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 15:32:51 -0700 (PDT)
In-Reply-To: <5e088bd90903151515g25ccb614q6537c5c64ee81cbd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Sun, Mar 15, 2009 at 3:15 PM, Steve Sakoman <sakoman@gmail.com> wrot=
e:

> I spoke a little too soon :-)
>
> The above fix does get me past the mmc issue, and everything looks
> fine from the serial console. =A0But I just noticed that DVI is broke=
n
> -- I suspect that some regulator magic may be required in the video
> driver too :-(

Heh, remember that comment about the crufty old protos I work with?

=46alse alarm.  I was using one that had a "broken dvi" tag on it :-)

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
