From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Fri, 20 Mar 2009 12:25:15 +0200
Message-ID: <94a0d4530903200325s2fd43525ub4d9e6cabb8fbe00@mail.gmail.com>
References: <94a0d4530903200317h403210f2u622b837be1e5d9a8@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02A925775D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:49669 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761018AbZCTKZS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 06:25:18 -0400
Received: by fg-out-1718.google.com with SMTP id e12so164187fga.17
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 03:25:15 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A925775D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Varide, Nischal" <nischal.varide@ti.com>

On Fri, Mar 20, 2009 at 12:22 PM, Gupta, Ramesh <grgupta@ti.com> wrote:
> Felipe,
>
>
>> -----Original Message-----
>> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>> Sent: Friday, March 20, 2009 3:48 PM
>> To: Hiroshi DOYU
>> Cc: Gupta, Ramesh; Kanigeri, Hari; Guzman Lugo, Fernando;
>> linux-omap@vger.kernel.org; ameya.palande@nokia.com
>> Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a
>> saner value
>>
>> On Fri, Mar 20, 2009 at 9:36 AM, Hiroshi DOYU
>> <Hiroshi.DOYU@nokia.com> wrote:
>> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> > Migrating to the existing mailbox driver("plat-omap/mailbox.c") is
>> > also another option to support multiple OMAP architectures
>> at the same
>> > time. That mailbox driver has already had a message queuing feature
>> > inside and it's buildable on OMAP3.
>>
>> Yeap, I have it in my to-do list, so if somebody doesn't beat
>> me to it I play with that.
>
> We already started looking into this :), made some progress,
> will provide more updates in a day or two.

Sweet! :)

-- 
Felipe Contreras
