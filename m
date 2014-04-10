From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Thu, 10 Apr 2014 12:20:00 +0100
Message-ID: <53467E60.4020504@codethink.co.uk>
References: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org> <53458E95.4080505@cogentembedded.com> <534598EF.3010102@wwwdotorg.org> <53459A48.1010003@cogentembedded.com> <063D6719AE5E284EB5DD2968C1650D6D0F6F43C3@AcuExch.aculab.com> <53467720.8000400@cogentembedded.com> <534679F1.3050607@codethink.co.uk> <063D6719AE5E284EB5DD2968C1650D6D0F6F44A4@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:52488 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S935056AbaDJLUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Apr 2014 07:20:07 -0400
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6F44A4@AcuExch.aculab.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Stephen Warren <swarren@wwwdotorg.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Peter.Chen@freescale.com" <Peter.Chen@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "balbi@ti.com" <balbi@ti.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>

On 10/04/14 12:14, David Laight wrote:
> From: Ben Dooks
>> On 10/04/14 11:49, Sergei Shtylyov wrote:
>>> On 10-04-2014 13:20, David Laight wrote:
>>>
>>>>>       It doesn't do any pin muxing. It switches SoC internal USB
>>>>> signals between
>>>>> USB controllers. The pins remain the same.
>>>
>>>> Doesn't something like that already happen for the companion USB1
>>>> controllers for USB2 ports?
>>>
>>>      Did you mean USB 1.1 and USB 2.0 controllers by USB1 and USB2?
>
> Yes.
>
> Why do you care which USB controller is driving the pins?
>
>>>> That also doesn't sound like you are changing the PHY.
>>>
>>>      I am changing one of the PHY registers that controls USB port
>>> (Renesas calls it channel) multiplexing.
>>>
>>>> I'd have thought that would happen if you had a single controller
>>>> that select between multiply PHY.
>>>
>>>      No, it's not the case.
>
> I realised that wasn't what you were doing, but at first it did seem
> to be what you were doing.
>
>> There is an interesting case, the USB3 shares a PHY with a SATA
>> and the PCIE and SATA also share a PHY on the R8A7790.
>
> Some of those look like pcb design decisions - so there is no dynamic
> changing, just config time plumbing.
> OTOH we are carrying PCIe using two SATA cables (the second carries the
> clock) so I suspect some SoC system pcbs may be able to support SATA
> or PCIe on the same connector).

Yes, which means we will probably want to support the case where
the USB3 is routed out of the PCIe lanes.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
