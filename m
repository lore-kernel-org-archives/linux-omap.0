From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Tue, 20 Sep 2011 17:07:21 +0530
Message-ID: <4E787AF1.5090400@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <9fa567d07831a1de1d0700151331b5c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57038 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730Ab1ITLh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 07:37:28 -0400
Received: by gxk21 with SMTP id 21so347931gxk.23
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 04:37:27 -0700 (PDT)
In-Reply-To: <9fa567d07831a1de1d0700151331b5c7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Tuesday 20 September 2011 04:54 PM, Vishwanath Sripathy wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
>> arm-kernel-bounces@lists.infradead.org] On Behalf Of Santosh
>> Shilimkar
>> Sent: Sunday, September 04, 2011 7:24 PM
>> To: linux-omap@vger.kernel.org
>> Cc: khilman@ti.com; Santosh Shilimkar; rnayak@ti.com;
>> linux@arm.linux.org.uk; linux-arm-kernel@lists.infradead.org
>> Subject: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde
>> support
>>

[...]

>> The series is tested on OMAP4430 SDP for suspend, hotplug and
>> CPUidle
>> with OMAP4 GP and HS (secure) devices.
>>
>> The following changes since commit
>> c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:
>>
>>   Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
>>
>> are available in the git repository at:
>>   git://gitorious.org/omap-sw-develoment/linux-omap-dev.git v3.1-
>> rc4-omap4-mpuss-pm
> I have tested these patch series after adding core retention support  (In
> suspend/resume path)[1] and it worked Fine. I do see that Core and MPU are
> entering CSWR upon suspend and able to wake up via uart.
> 
> You could add tested-by: Vishwanath BS < Vishwanath.bs@ti.com> if you
> want.
> 
Yes I want tested-by and will add your tested-by on the series.
Thanks for testing

Regards
Santosh
