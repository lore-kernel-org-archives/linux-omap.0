From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Thu, 4 Sep 2008 23:18:57 -0700
Message-ID: <5e088bd90809042318k762df6c8k79ef1fcbad9a8781@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <20080905011235.GZ23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:62248 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYIEGS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 02:18:59 -0400
Received: by py-out-1112.google.com with SMTP id p76so194891pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 23:18:58 -0700 (PDT)
In-Reply-To: <20080905011235.GZ23085@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 4, 2008 at 6:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Jarkko Nikula <jarkko.nikula@nokia.com> [080821 04:58]:
>> Here are two patches adding support for OMAP2430 in McBSP driver and
>> adding support for 2430 and 34xx in ASoC OMAP McBSP DAI driver.
>>
>> These are generated from top of currect l-o head but they apply also on
>> top of Hiroshi's virtual clock patches with some offsets.
>>
>> If you have change to try them out on those CPUs, I would be happy to
>> hear. I've tested these only on N810. Second patch will naturally go
>> through the alsa-devel when we have necessary McBSP patches upstream.
>
> Can you please refresh these against the current l-o head?

I've been testing these patches along with my Overo patches on the
current l-o head.  Audio is working fine, so the mcbsp changes haven't
broken anything.

I do miss having functional USB though :-)

Steve
