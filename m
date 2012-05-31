From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: Re: latest kernel for am35xx
Date: Thu, 31 May 2012 10:08:44 +0300
Message-ID: <CAP3+TErug0DmndHWCVsguw2+e_vPCB2McF5j0+AyrMj8eGa=MQ@mail.gmail.com>
References: <CAP3+TEr8vsnZPhAhgH-w7jAjWZTNQgWvsQ3cn_uz4TaX8c-Zgg@mail.gmail.com>
	<CAPjKCR_CiKA_vXNyfYHdJeqPMsv0SA_oRYg1-XzbO2C1vSbLug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48418 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2EaHIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 03:08:45 -0400
Received: by lbbgm6 with SMTP id gm6so606733lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 00:08:44 -0700 (PDT)
In-Reply-To: <CAPjKCR_CiKA_vXNyfYHdJeqPMsv0SA_oRYg1-XzbO2C1vSbLug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilkumar880@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi!

http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git
Does anyone knows a working branch/tag for am3517evm? I need the board
boots fine with Ethernet enabled and working.

I read a few messages at e2e forum and all of them report about broken
features.. I need wl1271 support in the kernel therefore I have to use
on the latest kernels.

2012/5/30 Anil Kumar <anilkumar880@gmail.com>:
> Hi Lisarden,
>
> Please try this.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>
> Thanks,
> Anil
>
> On Wed, May 30, 2012 at 2:21 PM, Maxim Podbereznyy <lisarden@gmail.co=
m>
> wrote:
>>
>> Hi!
>>
>> I need to use the latest kernel at a am3517 based board where
>> Craneboard schematic was used as a reference. In addition to Cranboa=
rd
>> scheme I have wl1271 chip added and therefore I need a kernel - one =
of
>> the latests to support wireless feature.
>>
>> The job I did:
>> 1) used kernel from Craneboard (Mistral repository) - 2.6.32, no wl1=
271
>> support
>> 2) OMAPPSP_04.02.00.07 - 2.6.37, tps65910 driver is broken
>> 3) AM335x PSP 04.06.00.07 - does not compile for am3517evm
>>
>> Can anybody suggest some alive kernel tree where tps65910 and wl1271
>> chips are supported? Having am3517evm or am3517crane board files wou=
ld
>> be a great help!
>>
>> Thanks in advance!
>> Max
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
