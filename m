From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Thu, 21 Aug 2008 14:51:04 -0700
Message-ID: <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:39559 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbYHUVvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 17:51:05 -0400
Received: by py-out-1112.google.com with SMTP id p76so131424pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 14:51:04 -0700 (PDT)
In-Reply-To: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I tried these patches with my ASoC driver for TWL4030/Overo (the
Gumstix 35XX based board) and they appear to work for that
combination.  When I get a chance I will try them with Beagle and EVM,
but I expect that should go well too.

I will submit the TWL4030 + Beagle, EVM, and Overo ASoC driver patches
as soon as I can track down a recurring crashing bug -- a null
substream pointer that seems to show up in certain circumstances.  Not
quite sure my driver is causing the error, but I would like to get to
the bottom of it.  It may be a compatibility issue with the version of
alsa lib I am using with the linux-omap kernel since the lib is
passing in the null pointer.  Have you seen anything like this on the
N810?

Regards,

Steve

On Thu, Aug 21, 2008 at 4:55 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> Here are two patches adding support for OMAP2430 in McBSP driver and
> adding support for 2430 and 34xx in ASoC OMAP McBSP DAI driver.
>
> These are generated from top of currect l-o head but they apply also on
> top of Hiroshi's virtual clock patches with some offsets.
>
> If you have change to try them out on those CPUs, I would be happy to
> hear. I've tested these only on N810. Second patch will naturally go
> through the alsa-devel when we have necessary McBSP patches upstream.
>
> --
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
