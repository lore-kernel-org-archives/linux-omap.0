From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: controlling CPU speed on N800/N810
Date: Sat, 04 Apr 2009 11:09:15 +0300
Message-ID: <871vs8vo0k.fsf@litku.valot.fi>
References: <8763hkvoi7.fsf@litku.valot.fi>
	<1238832066.8488.184.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:52049 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbZDDIJU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 04:09:20 -0400
Received: by bwz17 with SMTP id 17so1231465bwz.37
        for <linux-omap@vger.kernel.org>; Sat, 04 Apr 2009 01:09:17 -0700 (PDT)
In-Reply-To: <1238832066.8488.184.camel@localhost> (Igor Stoppa's message of "Sat\, 04 Apr 2009 11\:01\:06 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: igor.stoppa@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Igor Stoppa <igor.stoppa@nokia.com> writes:

> Hi,
> On Sat, 2009-04-04 at 09:58 +0200, ext Kalle Valo wrote:
>
>> Is it possible to change CPU speed in latest linux-omap kernels?
>
> afaik, no, but that makes your job easier, the ARM clock should be
> 330MHz - at least that's what TI supports and recommends when also the
> DSP is in use

Ok, thanks for the info. 

I got better wi-fi throughput with nokia 2.6.21 kernel compared to
linux-omap kernels, but the CPU speed difference will most likely
explain that. I'm assuming that DVFS increased the CPU speed over 400
MHz when running throughtput tests on nokia 2.6.21 kernel.

If anyone have hints or pointers how to overclock linux-omap kernels,
I'm all ears :)

-- 
Kalle Valo
