From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Tue, 7 Sep 2010 11:49:47 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087031162D17B@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>	<20100902075605.GB2962@matterhorn.lan>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCED1488@dbde02.ent.ti.com>
	<AANLkTinmWTAwckEJJs8d4BW3PVRHSBwy4i-w=MNe5eDX@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC356087031162CEB7@dbde02.ent.ti.com>
 <AANLkTikT+idycF5jo7h15+E3suVKN9bNB8N+vqGvRge1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57962 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab0IGGT7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 02:19:59 -0400
In-Reply-To: <AANLkTikT+idycF5jo7h15+E3suVKN9bNB8N+vqGvRge1@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jean,

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Monday, September 06, 2010 9:53 PM
> To: Sripathy, Vishwanath
> Cc: Shilimkar, Santosh; Amit Kucheria; Kevin Hilman; linaro-dev@lists.linaro.org;
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
> 
> Hi Vishwa,
> 
> On Mon, Sep 6, 2010 at 1:15 PM, Sripathy, Vishwanath
> <vishwanath.bs@ti.com> wrote:
> > I did some profiling of assembly code on OMAP3630 board (ZOOM3). In worst case
> it takes around 3.28ms and best case around 2.93ms for mpu off mode.
> Can you give a bit more details? Which measurement has been taken (ASM
> only, sleep, wake-up ...?) and what are the significant figures?
Measurement has been done for save (as part of sleep sequence) and restore routine (part of wake up sequence) in assembly code. The above number indicates total time spent in save and restore of ARM context. 

> 
> >For MPU INACTIVE/RET, it is less than 30us.
> Mmh that is the resolution of the 32kHz timer, so I guess you get
> either 0 or 1 timer cycle depending when you start the measurement.
> IMO the 32kHz timer is too slow to measure those fast events.
Yes I agree. When we use trace events, I believe it would be more accurate as it is based on ARM perf counters. 

Vishwa
> 
> > However as Kevin mentioned in other email, it would be better to find out a way to
> trace inside assembly code as well.
> OK that could be done but first I would like to make sure such a
> complication is  needed.
> 
> >
> > Regards
> > Vishwa
> 
> Jean
