From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Anyone using an ISP1505?
Date: Fri, 18 Dec 2009 13:10:46 -0600
Message-ID: <4B2BD3B6.20407@billgatliff.com>
References: <4B2A7FFB.6090909@billgatliff.com> <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:41684 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbZLRTKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 14:10:36 -0500
Received: by ywh12 with SMTP id 12so3733568ywh.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 11:10:35 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Gadiyar, Anand wrote:
>> I'm working on an OMAP3530CUS board that uses an ISP1505 USB PHY, and I
>> haven't gotten much luck getting the kernel to recognize any USB
>> devices.  No luck, actually.  :)  My oscilloscope and the schematic say
>> that the hardware is wired up properly, I'm just wondering if anyone has
>> a similar configuration that's working for them--- and which kernel they
>> are using?
>>     
>
> Is it with the OTG controller or with the EHCI controller?
>   

The pins of the ISP1505 are tied to pins T24, T23, and so on of the
OMAP3530CUS, which on my schematic are labeled UH0_D0, UH0_D1, etc. 
That's EHCI, right?  But I have both the EHCI and MUSB drivers enabled,
and both appear to initialize properly according to the kernel logs.

> The NXP ISP1505 is supposed to be transparent - no programming usually
> required.
>   

That's what I thought.  I have the "nop" transceiver driver installed.

> If it's with the EHCI controller, you need to take care of a couple of
> issues on the board (due to the input clocking mode used in the OMAP3).
>   

Can you elaborate?  Thanks!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

