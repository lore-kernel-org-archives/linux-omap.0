From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: [ASK] OMAP 3430 LDP Trouble
Date: Tue, 06 Apr 2010 14:44:53 -0600
Message-ID: <4BBB9D45.20907@mlbassoc.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0322418AC7@dbde02.ent.ti.com>	 <o2kd9ca78711004061327ibd323aa5yfbdf1f6a8e194200@mail.gmail.com>	 <4BBB99A8.6060308@mlbassoc.com> <v2hd9ca78711004061340v705e23adj22adce1945b6b81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:33743 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab0DFUpD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 16:45:03 -0400
In-Reply-To: <v2hd9ca78711004061340v705e23adj22adce1945b6b81@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Vimal Singh <vimal.newwork@gmail.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 04/06/2010 02:40 PM, Tar Gz wrote:
> i don't know, i'm forget to setting up my environment variable mmcinit
> or my sd card can't booting / bootable....but if i'm boot from nadn
> and can enter prompt, my ldp board can read my sd card...can load
> kernel from my sd card

You'll be much better off figuring out how to boot from the SD card.
There are many "how to" documents on this for the OMAP - just follow
the cookbook.  Then you'll have the pieces you need to repair your
NAND copy and move on.

> On 4/7/10, Gary Thomas<gary@mlbassoc.com>  wrote:
>> On 04/06/2010 02:27 PM, Tar Gz wrote:
>>> yes, i can't boot from nand because i erase it and i can't boot from
>>> my sd card..
>>
>> Why can't you boot from the SD card?
>>
>>> okey i will try boot from serial..hope this help
>>>
>>> best regards,
>>> Aldyth M
>>>
>>> On 4/7/10, Gadiyar, Anand<gadiyar@ti.com>   wrote:
>>>> Gadiyar, Anand wrote:
>>>>> Tar Gz wrote:
>>>>>> if NAND support is currently missing for OMAP3430 LDP,,how i boot my
>>>>>> ldp again like before?...any idea?
>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>> If I understand you correctly, you now have a non-booting
>>>>> LDP, and want
>>>>> to get a bootloader flashed on it?
>>>>>
>>>>> You may need to do a serial boot.
>>>>>
>>>>> Maybe this (old, and no longer maintained) page will help?
>>>>>
>>>>> <https://gforge.ti.com/gf/project/omapzoom/wiki/?pagename=BootingAndFlashing>
>>
>> --
>> ------------------------------------------------------------
>> Gary Thomas                 |  Consulting for the
>> MLB Associates              |    Embedded world
>> ------------------------------------------------------------
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
