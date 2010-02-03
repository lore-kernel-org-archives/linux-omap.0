From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: dspbridge patches in patchwork
Date: Wed, 3 Feb 2010 12:17:34 -0600
Message-ID: <4B69BDBE.1090108@ti.com>
References: <1265199981.2740.8.camel@sanganak>	 <20100203170314.GB22747@atomide.com>  <20100203170815.GC22747@atomide.com> <1265218161.10175.2.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43051 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab0BCSRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Feb 2010 13:17:38 -0500
In-Reply-To: <1265218161.10175.2.camel@sanganak>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>

On 2/3/2010 11:29 AM, Ameya Palande wrote:
> Hi Omar,
>
> On Wed, 2010-02-03 at 18:08 +0100, ext Tony Lindgren wrote:
>> * Tony Lindgren<tony@atomide.com>  [100203 09:00]:
>>> * Ameya Palande<ameya.palande@nokia.com>  [100203 04:24]:
>>>> Hi Tony,
>>>>
>>>> As more and more people start contributing to dspbridge code (as we have
>>>> seen recently) tracking patches is becoming difficult.
>>>>
>>>> Is it possible to delegate dspbridge patches to dspbridge maintainer in
>>>> patchwork?
>>>
>>> Yeh sure. All it takes is registering a user for pw.k.o and selecting
>>> linux-omap as the project.
>>>
>>> Then I need send an email with the pw.k.o user name to allow changing
>>> the omap patch status.
>>
>> If you just want to follow the dspbridge patches, you can configure
>> your pwclient:
>>
>> $ cat /home/tmlind/.pwclientrc
>> # Sample .pwclientrc file for the linux-omap project,
>> # running on patchwork.kernel.org.
>> #
>> # Save this file to ~/.pwclientrc
>> #
>> [base]
>> url: http://patchwork.kernel.org/xmlrpc/
>> project: linux-omap
>>
>> # Adding authentication parameters will allow you to use the 'update'
>> # command on patches that you are allowed to edit.
>> # [auth]
>> # username: yourusername
>> # password: yourpassword
>>
>> Then to see all the dspbridge patches, just do:
>>
>> $ pwclient search dspbridge
>> ID    State        Name
>> --    -----        ----
>> 6777  Not Applicable [1/3] DSPBRIDGE Offmode and DVFS Support
>> 6778  Not Applicable [2/3] DSPBRIDGE DVFS and OFF mode support with OPP2
>> 6814  Not Applicable [1/1] DSPBRIDGE Fix condition statement for Global Flush
>> ...
>>
>> Regards,
>>
>> Tony
>
> Will you maintain dspbridge patches in patchwork?

I have been (since few days ago):
http://patchwork.kernel.org/bundle/omar_rmz/dspbridge/?state=*&archive=both

but will be a lot better to be able to change state instead of moving to 
"dspbridge-pushed" bundle :)

Best Regards,

Omar
