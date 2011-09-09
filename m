From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Fri, 09 Sep 2011 09:55:20 +0530
Message-ID: <4E699530.6060806@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <CAORVsuX4wZOr71RahnLUHwDMT1B1593bdKFAynNqtVXJOWVazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46406 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab1IIEZa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 00:25:30 -0400
Received: by mail-gx0-f179.google.com with SMTP id 1so722332gxk.24
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 21:25:28 -0700 (PDT)
In-Reply-To: <CAORVsuX4wZOr71RahnLUHwDMT1B1593bdKFAynNqtVXJOWVazQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Friday 09 September 2011 01:45 AM, Jean Pihet wrote:
> Hi Santosh,
>
> On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> This series adds OMAP4 MPUSS (MPU SubSystem) power management support for
>> suspend (S2R), CPU hotplug and CPUidle.
>>
>> Most of these patches have been posted and reviewed earlier [1] on the list
>> and have missed last couple of merge windows because of dependencies.
>> New set of patches have diverged more and hence the series version
>> continuity isn't maintained.
>>
>> Below are the main updates from previous versions.
>> - Use of generic ARM suspend hooks instead of OMAP custom code.
>> - Making use of common GIC code instead of OMAP custom code.
>> - Use of generic CPU PM notifiers for CPUIDLE and suspend.
>> - Use of CPU PM notifiers and hotplug notifiers for GIC extension.
>> - PM support of OMAP4 HS devices.
>> - Introduction of interconnect barriers as per the OMAP4 requirements.
>>
>> Special thanks to,
>> - Kevin Hilman for the detailed reviews.
>> - Russell for adding the L2 cache handling support to generic suspend.
>> - Colin Cross for the generic CPU PM notifier patches.
>> - Rajendra Nayak and Paul Walmsley for clock-domain sequencing series.
>>
>> Below series has dependency on Russell's L2 generic suspend support [2]
>> and earlier posted CPU PM notifiers series [3].
>> An integrated branch with these dependencies can be found here [4].
>>
>> The series is tested on OMAP4430 SDP for suspend, hotplug and CPUidle
>> with OMAP4 GP and HS (secure) devices.
>>
>> The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:
>>
>>   Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
>>
>> are available in the git repository at:
>>   git://gitorious.org/omap-sw-develoment/linux-omap-dev.git v3.1-rc4-omap4-mpuss-pm
>
> Some comments have been sent on this patch set, otherwise OK after review.
>
> FWIW:
> Acked-by: Jean Pihet<j-pihet@ti.com>
>
Thanks

Regards
Santosh
