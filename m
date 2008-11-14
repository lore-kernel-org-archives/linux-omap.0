From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: Serial port crashes omap3 on boot with 2.6.28rc4
Date: Fri, 14 Nov 2008 16:29:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B36B5DC4@dbde02.ent.ti.com>
References: <D4C9733E-73D0-403F-893D-910C59EDD20A@student.utwente.nl>
 <D8E4F982-85F9-4DAB-8BC4-69135109EBC9@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47938 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbYKNK7d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 05:59:33 -0500
In-Reply-To: <D8E4F982-85F9-4DAB-8BC4-69135109EBC9@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Can you try without CONFIG_DEBUG_LL? 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Koen Kooi
>Sent: Friday, November 14, 2008 4:27 PM
>To: linux-omap@vger.kernel.org List
>Subject: Re: Serial port crashes omap3 on boot with 2.6.28rc4
>
>
>Op 14 nov 2008, om 11:17 heeft Koen Kooi het volgende geschreven:
>
>> Hi,
>>
>> I updated to the current head
>> (5ecf98b76fa95078277c9037bb01640fd3de5e2c) and get this on boot
>> (with debug_ll) on omap3evm:
>>
>> <7>omap-dss DISPLAY: panel 'panel-dvi' registered
>> <6>Serial: 8250/16550 driver4 ports, IRQ sharing enabled
>> <6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
>> <....,...:4...4../0400..1=......F1.5S.<....,...:4.3^F!^C../
>> 0.0^F00..1=7K....F1.5S.<.....%;..&=%.".$.<."F:..5. .!*$.<...0^G..
>> 5. .!*$.<...%^B-J/.0.."..%C0^G...5(V6..!^C0.^D000)^V.6...%C0^G%C%.
>> %^C!"2^G.."...$...&R...%C0^G...8).%
>> ..'%:%.#. ...,.<.!.74^C3..:..#.#V%...1.V..<.).5...v8. {...$.r.
>> 3...6......
>>
>> Any ideas?
>
>I get this on rc3 now as well, it seems that the evm dss2 patch has
>some side effects, console is restored when userspace launches getty
>
>regards,
>
>Koen
