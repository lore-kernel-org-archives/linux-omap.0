From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sat, 23 Aug 2008 17:02:29 +0530
Message-ID: <dfeb90390808230432gad11e2y3188a1ac9ed2d939@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:34072 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbYHWLcb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 07:32:31 -0400
Received: by ti-out-0910.google.com with SMTP id b6so505185tic.23
        for <linux-omap@vger.kernel.org>; Sat, 23 Aug 2008 04:32:29 -0700 (PDT)
In-Reply-To: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Jarkko,

I applied your patch manually on the latest omap-git and tested ASOC
driver on omap2evm board with tlv320aic34 codec. It works fine.
omap2evm is based on  omap2430.

Best Regards,
Arun KS

On Thu, Aug 21, 2008 at 5:25 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
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
