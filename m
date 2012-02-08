From: "Turgis, Frederic" <f-turgis@ti.com>
Subject: RE: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard ES
Date: Wed, 8 Feb 2012 18:19:25 +0000
Message-ID: <28BE1A38672C8B4481BB423D0FD1F22E18F07B3E@DNCE03.ent.ti.com>
References: <4F31A91B.8080106@umich.edu> <4F32063F.1020607@linaro.org>
	<51DAA6EF-1C3B-4964-8447-893D295E51A1@umich.edu>
 <1328720930.9030.0.camel@js-netbook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab2BHSTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:19:32 -0500
In-Reply-To: <1328720930.9030.0.camel@js-netbook>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, Andrew Richardson <chardson@umich.edu>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

Hi,

Never had any issue with 32K and gettimeofday() on Panda (but just starting to use clock_gettime()). It was used to timestamp events happening every few ms or 100s of us.

I would advise as a check:
- read clock_gettime()/gettimeofday() and in parallel 32K register (map and read physical address 0x4A304010) to check behaviour.
- There is potential issue (that we have never seen) when reading 32K register. Worked around by calling clock_gettime()/gettimeofday() twice (we never do that and still it works so ...)

We have been doing tests in the past like while(1) {gettimeofday(); printf("time ...")} and it worked correctly, exhibiting the 30.5us accuracy

Regards
Fred



Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----
From: linaro-dev-bounces@lists.linaro.org [mailto:linaro-dev-bounces@lists.linaro.org] On Behalf Of John Stultz
Sent: Wednesday, February 08, 2012 6:09 PM
To: Andrew Richardson
Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
Subject: Re: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard ES

On Wed, 2012-02-08 at 04:32 -0500, Andrew Richardson wrote:
> Ah, very interesting.

>         > dmesg | grep clock
>         [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
>         [    0.000000] sched_clock: 32 bits at 32kHz, resolution
>         30517ns, wraps every 131071999ms

Hrm. So 30us is still much smaller then the 2.5ms you were seeing. So
that doesn't fully explain the behavior.

thanks
-john
