From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Mon, 25 Aug 2008 14:50:04 -0700
Message-ID: <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080825213510.GC14939@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:31560 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbYHYVuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 17:50:05 -0400
Received: by py-out-1112.google.com with SMTP id p76so1181310pyb.10
        for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 14:50:04 -0700 (PDT)
In-Reply-To: <20080825213510.GC14939@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> ALSA sound/core/pcm_native.c:2573: BUG? (substream != ((void *)0))
>
> Hmmm... this looks odd.
>
> Jarkko, shouldn't that snd_assert() in pcm_native.c check if substream
> _is_ NULL instead of !is NULL ?

I found this odd also, but looking in
Documentation/sound/alsa/DocBook/writing-an-alsa-driver I found that
the sense of the test is indeed the reverse of what you would expect
-- you are specifying the condition that *should* be met, and the
action to take if it is not.

I can also verify that the substream pointer is indeed null -- the
reason I enabled alsa debugging in the first place is that the kernel
was crashing due to a null pointer :-)

Steve
