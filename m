From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Tue, 26 Aug 2008 03:08:41 +0300
Message-ID: <20080826000837.GK14939@frodo>
References: <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com> <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com> <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com> <20080825213510.GC14939@frodo> <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com> <20080825215258.GF14939@frodo> <5e088bd90808251530n1fb59656p6e994f944add7109@mail.gmail.com> <20080825224003.GH14939@frodo> <20080825225450.GI14939@frodo> <5e088bd90808251634m69a9d865n89defa575fea097f@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51473 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYHZAI6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 20:08:58 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90808251634m69a9d865n89defa575fea097f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: me@felipebalbi.com, Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 25, 2008 at 04:34:40PM -0700, Steve Sakoman wrote:
> > can you also apply this other patch:
> >
> > diff --git a/sound/core/pcm.c b/sound/core/pcm.c
> 
> That patch didn't seem to have an effect, pretty much the same crash:

Hmm... so more investigation is needed but now is already too late for
me, it's past 3am :-p

If Jarkko doesn't get a fix before me (I'm pretty sure he will :-p) I'll
try to dig more when I wake up.

But the problems seems to be on the file open() path. Try to track down
the use of struct snd_pcm_substream, starting at
pcm_native.c:snd_pcm_open_file().

Put some printks around that function and see when substream is getting
nulled.

Something like:

printk(KERN_INFO "%s %d substream %p\n", __func__, __LINE__, substream);

And go down the functional calls following the ones that have a struct
snd_pcm_substream as argument. That will probably allow you to see where
substream is getting NULLed and try to guess a fix for that.

-- 
balbi
