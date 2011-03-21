From: Matt Johnson <johnso87@crhc.illinois.edu>
Subject: Re: cpufreq support for the Beagleboard.
Date: Mon, 21 Mar 2011 13:44:48 -0500
Message-ID: <4D879CA0.6070904@crhc.illinois.edu>
References: <AANLkTi=mWbpi7i6if5TdBCoi0bUFGWcxOba1kZ+6EePa@mail.gmail.com><641332d61bd84a5de4483dbb496ecd5a@mail.gmail.com> <AANLkTimfoR=36BcAFooNWzUEVJy1BLpdQji2hB1vnd1T@mail.gmail.com> <859a150e6ceac11b05685418a0c9243c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from usps2.crhc.illinois.edu ([130.126.143.231]:33715 "EHLO
	usps.crhc.uiuc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1CUSzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Mar 2011 14:55:41 -0400
In-Reply-To: <859a150e6ceac11b05685418a0c9243c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: javier Martin <javier.martin@vista-silicon.com>, linux-omap@vger.kernel.org

On 03/21/2011 08:24 AM, Vishwanath Sripathy wrote:
>> -----Original Message-----
>> From: javier Martin [mailto:javier.martin@vista-silicon.com]
>> Sent: Monday, March 21, 2011 5:40 PM
>> To: Vishwanath Sripathy
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: cpufreq support for the Beagleboard.
>>
>> Hi,
>> thank you for your fast answer.
>>
>> I've been testing the repository you pointed me and I found that only
>> 300MHz and 600MHz can be selected in the Beagleboard xM.
>> Couldn't we work until 1000MHz?
> 1G is disabled by default in OPP table I suppose. Pls enable it (in
> omap36xx_opp_def_list) if your board supports it.
My understanding was that the mainline kernel needed support for 
SmartReflex 1.5 and Adaptive Body Biasing (ABB), as found in TI's 
linux-omap-psp 2.6.32, before it was safe to enable the 1GHz OPP on the 
DM3730 (for e.g., Beagleboard xM).  Is this not the case?  Can we really 
just flip the bit in the OPP table?

>> Do you know what's left for those patches to enter mainline? Is
>> anybody working on it?
> OMAP cpufreq is undergoing some architecture/design changes and this is
> WIP.
>
> Vishwa
Thanks,
Matt

>> Thanks.
>>
>> --
>> Javier Martin
>> Vista Silicon S.L.
>> CDTUC - FASE C - Oficina S-345
>> Avda de los Castros s/n
>> 39005- Santander. Cantabria. Spain
>> +34 942 25 32 60
>> www.vista-silicon.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
