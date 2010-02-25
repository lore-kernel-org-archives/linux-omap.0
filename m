From: Venkatraman S <svenkatr@ti.com>
Subject: Re: DMA example
Date: Thu, 25 Feb 2010 11:52:37 +0530
Message-ID: <618f0c911002242222n1f885fdcnc0c93fb20fa83a13@mail.gmail.com>
References: <4B857F2F.7000201@balister.org>
	 <20100224203555.GT28173@atomide.com> <4B85A8AD.5060206@balister.org>
	 <20100224225231.GA28173@atomide.com> <4B85DF4D.9020007@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202]:60036 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab0BYG25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 01:28:57 -0500
Received: by iwn40 with SMTP id 40so4972174iwn.22
        for <linux-omap@vger.kernel.org>; Wed, 24 Feb 2010 22:28:57 -0800 (PST)
In-Reply-To: <4B85DF4D.9020007@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 25, 2010 at 7:54 AM, Philip Balister <philip@balister.org> =
wrote:
> On 02/24/2010 02:52 PM, Tony Lindgren wrote:
>>
>> * Philip Balister<philip@balister.org> =A0[100224 14:28]:
>>>
>>> On 02/24/2010 12:35 PM, Tony Lindgren wrote:
>>>>
>>>> * Philip Balister<philip@balister.org> =A0 [100224 11:31]:
>>>>>
>>>>> I am trying to setup a dma operation to copy memory from GPMC
>>>>> address space into RAM. The only examples using the omap-dma api =
use
>>>>> hardware triggers.
>>>>>
>>>>> When I start a transfer, I end up with a DMA transaction error wh=
en
>>>>> I start the transfer.
>>>>>
>>>>> Does anyone have a good example of a software transfer? Currently=
, I
>>>>> am tracing the omap dma api to see how things map into the regist=
ers
>>>>> ....

=46or the record, some unit tests for OMAP device drivers are available=
 at
http://dev.omapzoom.org/?p=3Dricho/device_driver_test.git;a=3Dsummary.
In dma/test_code/utils/dma/dma_addrmode_doubleidx.c, there's normal
memory to memory transfer example..
Most of the omap_dma* api calls are done via dma_single_channel.c file.

Hope this helps,

Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
