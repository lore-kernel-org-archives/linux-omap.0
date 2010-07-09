From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] omap3: sr: improve errors handling
Date: Fri, 9 Jul 2010 10:51:33 -0500
Message-ID: <4C374585.7030104@ti.com>
References: <1278681612-10521-1-git-send-email-dedekind1@gmail.com>	 <1278681612-10521-2-git-send-email-dedekind1@gmail.com>	 <5A47E75E594F054BAF48C5E4FC4B92AB032391F34E@dbde02.ent.ti.com> <1278690245.9953.142.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47508 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757201Ab0GIPvk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 11:51:40 -0400
In-Reply-To: <1278690245.9953.142.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

Artem Bityutskiy had written, on 07/09/2010 10:44 AM, the following:
> On Fri, 2010-07-09 at 20:35 +0530, Gopinath, Thara wrote:
>>>> -----Original Message-----
>>>> From: Artem Bityutskiy [mailto:dedekind1@gmail.com]
>>>> Sent: Friday, July 09, 2010 6:50 PM
>>>> To: linux-omap@vger.kernel.org
>>>> Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara; Peter p2 De Schrijver
>>>> Subject: [PATCH 2/2] omap3: sr: improve errors handling
>>>>
>>>> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>>>>
>>>> Do not forget to check the 'platform_device_add_data()' error code
>>>> in 'omap_device_build_ss()'.
>> Hello Artem,
>>
>> Can we have a better subject and description. The subject esp has got
>> nothing to do with the fix.
> 
> Hmm, I do not see why you think so. I think the subject is fine - the
> patch improves error handling in the SR code. Then description says how
> exactly it improves it - it makes the code to not forget to check the
> return code, and it tells in which function and which return code.
> 
> So the logic is:
> 
> 1. The subject line is a short description which gives the idea what the
> commit is about. So, my subject line says:
>   1.1. It is about omap3 (which is true)
>   1.2. It is about sr (which is true)
I think Thara's contention is that this is omap_device related- yeah SR 
is one of the users of omap_device, but there are much more folks using 
omap_device in l-o today.

>   1.3. It improves error handling (which is also true)
> 
> So the subject line is descriptive enough. It does not have to provide
> all glory details.
> 
> Then the description provides the details.
> 


-- 
Regards,
Nishanth Menon
