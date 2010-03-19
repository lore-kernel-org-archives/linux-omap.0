From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Fri, 19 Mar 2010 16:49:24 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CACBD655@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
	 <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
	 <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
	 <94a0d4531003190918v7e943d5ax16baf6945472530c@mail.gmail.com>
 <94a0d4531003191200r425652c3ybf505c353b2ad847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46340 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309Ab0CSVt2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 17:49:28 -0400
In-Reply-To: <94a0d4531003191200r425652c3ybf505c353b2ad847@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>



>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Friday, March 19, 2010 1:00 PM
>To: Hebbar, Shivananda
>Cc: Guzman Lugo, Fernando; linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya
>Palande; felipe.contreras@nokia.com
>Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
>
>On Fri, Mar 19, 2010 at 6:18 PM, Felipe Contreras
><felipe.contreras@gmail.com> wrote:
>> On Fri, Mar 19, 2010 at 6:05 PM, Hebbar, Shivananda <x0hebbar@ti.com>
>wrote:
>>> Client app must register for MMUFault/DSPSysError events. Then only
>>> You will receive notifications.
>>
>> It is registered, and it was receiving notifications on old versions
>> of the bridge... not any more.
>
>Strike that strike... the regression happens only with this patch.
>Apparently the get_events ioctl fails constantly... that's why the
>MMUFAULT is not reported.

Do you mean applying DSP recovery process you are no able to receive MMUFault notifications?

I am going to check that case. Is there any possibility that the process is stuck waiting other event?

Regards,
Fernando.

>
>--
>Felipe Contreras
