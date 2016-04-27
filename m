From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: DRA7x: dts: Fix the 32kHz clock calculation
Date: Wed, 27 Apr 2016 22:47:39 +0300
Message-ID: <5721175B.8030904@ti.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
 <1461693269-19436-3-git-send-email-Linux.HWI@garmin.com>
 <5720A51E.2000900@ti.com> <5720C77A.3020708@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5720C77A.3020708-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "J.D. Schroeder" <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: "J.D. Schroeder" <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>, "J, Keerthy" <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 27/04/16 17:06, J.D. Schroeder wrote:
> On 04/27/2016 06:40 AM, Tero Kristo wrote:
>> On 26/04/16 20:54, J.D. Schroeder wrote:
>>> This commit fixes the 32kHz clock (sys_32k_ck) calculation to be
>>> correctly based on the SYS_CLK1 (sys_clkin1) frequency. Based on the
>>> TRM CTRL_CORE_BOOTSTRAP[9:8] SPEEDSELECT, set by the SYSBOOT[9:8]
>>> board jumpers according to the SYS_CLK1 frequency, the frequency of
>>> the 32kHz FUNC_32K_CLK is set to SYS_CLK1/610. The following
>>> sys_32k_ck frequencies get used for different SYS_CLK1 frequencies:
>>>           0b00: Unknown  -> 32768 Hz crystal from CLKIN_32K pin
>>>           0b01: 20   MHz -> 32787 Hz clock (SYS_CLK1/610)
>>>           0b10: 27   MHz -> 44262 Hz clock (SYS_CLK1/610)
>>>           0b11: 19.2 MHz -> 31475 Hz clock (SYS_CLK1/610)
>>
>> A patch doing the same thing is already in mainline, see:
>>
>> commit eea08802f586acd6aef377d1b4a541821013cc0b
>> Author: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>> Date:   Mon Apr 4 11:07:15 2016 +0530
>>
>>      ARM: dts: dra7: Correct clock tree for sys_32k_ck
>>
>> So, this one can be ignored.
>
> My change had no issue when applying to the tip of master and I'm not seeing
> that SHA1 in mainline. Are you saying it is in another repo ready to be sent
> to mainline for the next release cycle?
>

The patch is merged already in 4.6-rc3.

Which repo / version are you using as baseline?

-Tero
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
