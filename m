From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: omap voltage management
Date: Sat, 21 Mar 2015 21:18:34 +0200
Message-ID: <CAJ2oMhKLL8O2Pngg4=YwLmOMApvnJm9UPUhu+SJ421H72ONhTg@mail.gmail.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>
	<20150319202750.GM31346@atomide.com>
	<CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36365 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbbCUTSf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Mar 2015 15:18:35 -0400
Received: by wgra20 with SMTP id a20so114871013wgr.3
        for <linux-omap@vger.kernel.org>; Sat, 21 Mar 2015 12:18:34 -0700 (PDT)
In-Reply-To: <CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Mar 20, 2015 at 7:11 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>> We currently are missing dm8148 support from mainline, dm8168
>> does have basic support now. Adding dm8148 will hopefully happen
>> too with time permitting :)
>>
>
> Hi Tony,
>
> What is exactly the "voltage driver" capability ? Does it mean that it
> does not support AVS (feature for power saving) ?
>
> Regards,
> Ran

Hi Tony,

Is it AVS or "voltage scaling" (used with cpufreq) ?

Thank you,
Ran
