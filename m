From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v3 00/13] OMAP: McBSP: hwmod adaptation and runtime conversion
Date: Thu, 24 Feb 2011 14:32:31 +0530
Message-ID: <AANLkTinLG8imW_wCxvQVyQWJ9PNS72LrbzuN=R=rMZKT@mail.gmail.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
	<4D636651.30904@nokia.com>
	<AANLkTinfymZZRDwXHsvOhBU7KTVBRakdZAp46M3JfGD6@mail.gmail.com>
	<20110223213429.GA30316@atomide.com>
	<AANLkTi=TjyOvnXEhyRv+4yF7-rwoDCORqXKw9--_9qOO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:32804 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753907Ab1BXJCe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 04:02:34 -0500
Received: by mail-yi0-f43.google.com with SMTP id 13so228648yia.2
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 01:02:31 -0800 (PST)
In-Reply-To: <AANLkTi=TjyOvnXEhyRv+4yF7-rwoDCORqXKw9--_9qOO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, p-basak2@ti.com, charu@ti.com, shubhrajyoti@ti.com

On Thu, Feb 24, 2011 at 11:51 AM, ABRAHAM, KISHON VIJAY <kishon@ti.com>=
 wrote:
> On Thu, Feb 24, 2011 at 3:04 AM, Tony Lindgren <tony@atomide.com> wro=
te:
>> * ABRAHAM, KISHON VIJAY <kishon@ti.com> [110223 02:11]:
>>> >>
>>> >> Created on top of linux OMAP master (linux-omap-2.6 :master)
>>
>> Does not look like that's the case. This does not seem to compile
>> because of .name usage in omap_hwmod_addr_space. Also contains
>> omap_device idle calls that we don't have merged either.
>
> =A0McBSP hwmod and runtime patches depends on
> =A0http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
> =A0http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
> =A0http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134
> =A0to be compiled.
>
>>>
>>> =A0 Will you be merging this patch series?
>>
>> No yet. Please rebase on omap-for-linus at commit
>> 7cab8713b1ed0dab08ad6458f92a40b7ff4be619 and make sure each
>> patch compiles.
>
> =A0I couldn't find that commit id on omap-for-linus :-(. Anyways, I d=
id compile
> =A0test applying my current patch series on top of
> =A0HEAD (df7ffd317d36d36095c26bb57b3dd405274048e5) + API to modify
> =A0SYSCONFIG patch series.

   Ok. I'll rebase on omap-for-linus at commit
7cab8713b1ed0dab08ad6458f92a40b7ff4be619
   and send a new version.
>
> =A0Regards
> =A0Kishon
>
>>
>> Regards,
>>
>> Tony
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
