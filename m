From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: twl_mmc1_set_power problem, was: Re: Serial port crashes omap3 on boot with 2.6.28rc4
Date: Fri, 14 Nov 2008 17:00:58 +0200
Message-ID: <6ed0b2680811140700m59531cd4o20052256bd81b5c7@mail.gmail.com>
References: <D4C9733E-73D0-403F-893D-910C59EDD20A@student.utwente.nl>
	 <D8E4F982-85F9-4DAB-8BC4-69135109EBC9@student.utwente.nl>
	 <571101AA-6E65-4BA6-8DF6-B445515010A1@student.utwente.nl>
	 <CA1477DD-3672-44B1-860D-86A662C7E7E7@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:17177 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYKNPBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 10:01:00 -0500
Received: by ey-out-2122.google.com with SMTP id 6so593581eyi.37
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 07:00:58 -0800 (PST)
In-Reply-To: <CA1477DD-3672-44B1-860D-86A662C7E7E7@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, ext David Brownell <david-b@pacbell.net>

On Fri, Nov 14, 2008 at 4:20 PM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>
> Op 14 nov 2008, om 13:15 heeft Koen Kooi het volgende geschreven:
>
>>
>> Op 14 nov 2008, om 11:56 heeft Koen Kooi het volgende geschreven:
>>
>>>
>>> Op 14 nov 2008, om 11:17 heeft Koen Kooi het volgende geschreven:
>>>
>>>> Hi,
>>>>
>>>> I updated to the current head (5ecf98b76fa95078277c9037bb01640fd3de5e2c)
>>>> and get this on boot (with debug_ll) on omap3evm:
>>>>
>>>> <7>omap-dss DISPLAY: panel 'panel-dvi' registered
>>>> <6>Serial: 8250/16550 driver4 ports, IRQ sharing enabled
>>>> <6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
>>>>
>>>> <....,...:4...4../0400..1=......F1.5S.<....,...:4.3^F!^C../0.0^F00..1=7K....F1.5S.<.....%;..&=%.".$.<."F:..5.
>>>> .!*$.<...0^G..5.
>>>> .!*$.<...%^B-J/.0.."..%C0^G...5(V6..!^C0.^D000)^V.6...%C0^G%C%.%^C!"2^G.."...$...&R...%C0^G...8).%
>>>> ..'%:%.#. ...,.<.!.74^C3..:..#.#V%...1.V..<.).5...v8.
>>>> {...$.r.3...6......
>>>>
>>>> Any ideas?
>>>
>>> I get this on rc3 now as well, it seems that the evm dss2 patch has some
>>> side effects, console is restored when userspace launches getty
>>
>> I can boot rc4 + dss2 + dss2-evm into userspace if the omap_rev() TWL
>> writes don't get triggered in board-omap3evm.c. Once those get run I get
>> more garbage and a crash, without them a little garbage that getty fixes up.
>
> After disabled the 8250 driver:
>
> <1>Unable to handle kernel NULL pointer dereference at virtual address
> 00000029
> <1>pgd = c0004000
> <1>[00000029] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT
> Modules linked in:
> CPU: 0    Not tainted  (2.6.28-rc4-omap1 #8)
> PC is at twl_mmc1_set_power+0x20/0xf8
> LR is at omap_mmc_set_ios+0x78/0x25c

Please try this patch:
http://marc.info/?l=linux-omap&m=122665977404264&w=2
