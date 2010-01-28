From: Nishanth Menon <nm@ti.com>
Subject: Re: omap3: pm: AVS enabled by default?
Date: Thu, 28 Jan 2010 09:29:59 -0600
Message-ID: <4B61AD77.6070601@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E22B429F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35862 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab0A1PaI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jan 2010 10:30:08 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E22B429F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Andrew Murray <amurray@mpc-data.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Premi, Sanjeev had written, on 01/28/2010 09:21 AM, the following:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Andrew Murray
>> Sent: Thursday, January 28, 2010 7:53 PM
>> To: linux-omap@vger.kernel.org
>> Subject: omap3: pm: AVS enabled by default?
>>
>> Hello,
>>
>> I noticed that Smart Reflex AVS is not turned on by default - and must
>> be manually enabled from user-land through the sr_vddX_autocomp
>> controls.
>>
>> Are there any plans to enable this by default, or perhaps via 
>> a KConfig
>> option in the future?
>>
>> I ask because the longer a boot time, the longer the device is running
>> without AVS (assuming it's not enabled by a boot loader) - and on a
>> mobile device with frequent power on/offs this duration could add up
>> leading to a potential missed power saving? I appreciate the 
>> saving may
>> be small - but would it be worthwhile?
you may want to consider upstart and move most of your drivers into 
modules rather than a static binary ;)

But your point is valid, some folks prefer to have AVS disabled in the 
system during boot  for couple of reasons I know of:
a) during system boot, OMAP is busy, avs comes into play during 
late_init and not early_init as it needs pm configurations, pmic setup 
all other stuff to be done.. so the delay between late_init and 
completion of boot is pretty minimal
b) few folks would like to start the boot without avs and enable it from 
userspace applications to allow debug of issues when avs is enabled 
(even if avs is enabled during that little time it is on.. they'd want 
to avoid it)..

> Some of the initial silicon revisions did not have the efuse data to
> Required for AVS. I believe AVS is disabled - by default - to ensure
> compatibility with these devices.
this should not be a problem - SR driver is smart and will look at it's 
data structures and say - oh, this device does not have efuse, so it 
will crib back saying - good try - but sorry, I cant enable avs at this 
OPP frequency because I dont have efuse data to program the SR AVS module..


All said and done, there are configurations which enable avs by default 
at boot - the corresponding variable is initialized as one in thier 
private trees..

-- 
Regards,
Nishanth Menon
