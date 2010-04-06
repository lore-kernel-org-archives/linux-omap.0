From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [ASK] OMAP 3430 LDP Trouble
Date: Wed, 7 Apr 2010 03:40:31 +0700
Message-ID: <v2hd9ca78711004061340v705e23adj22adce1945b6b81@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0322418AC7@dbde02.ent.ti.com>
	 <o2kd9ca78711004061327ibd323aa5yfbdf1f6a8e194200@mail.gmail.com>
	 <4BBB99A8.6060308@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60409 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab0DFUkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 16:40:33 -0400
Received: by vws13 with SMTP id 13so143293vws.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 13:40:32 -0700 (PDT)
In-Reply-To: <4BBB99A8.6060308@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Vimal Singh <vimal.newwork@gmail.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, linux-omap <linux-omap@vger.kernel.org>

i don't know, i'm forget to setting up my environment variable mmcinit
or my sd card can't booting / bootable....but if i'm boot from nadn
and can enter prompt, my ldp board can read my sd card...can load
kernel from my sd card

best regards,
Aldyth M

On 4/7/10, Gary Thomas <gary@mlbassoc.com> wrote:
> On 04/06/2010 02:27 PM, Tar Gz wrote:
>> yes, i can't boot from nand because i erase it and i can't boot from
>> my sd card..
>
> Why can't you boot from the SD card?
>
>> okey i will try boot from serial..hope this help
>>
>> best regards,
>> Aldyth M
>>
>> On 4/7/10, Gadiyar, Anand<gadiyar@ti.com>  wrote:
>>> Gadiyar, Anand wrote:
>>>> Tar Gz wrote:
>>>>> if NAND support is currently missing for OMAP3430 LDP,,how i boot my
>>>>> ldp again like before?...any idea?
>>>>>
>>>>
>>>> <snip>
>>>>
>>>> If I understand you correctly, you now have a non-booting
>>>> LDP, and want
>>>> to get a bootloader flashed on it?
>>>>
>>>> You may need to do a serial boot.
>>>>
>>>> Maybe this (old, and no longer maintained) page will help?
>>>>
>>>> <https://gforge.ti.com/gf/project/omapzoom/wiki/?pagename=BootingAndFlashing>
>
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
>
