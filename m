From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Thu, 8 Mar 2012 11:43:47 +0530
Message-ID: <CAAL8m4zH3EntrAd83g1Dn_SQdpu7XcCQZvaB7=qzxmBReFMaaA@mail.gmail.com>
References: <4F3E0EB7.9060803@ti.com> <874nuizfyf.fsf@ti.com>
 <4F4613B7.8010601@kynesim.co.uk> <4F4B9405.9070702@ti.com>
 <CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com>
 <CAOCHtYjVhbmi1=S6TZLQTUAb=cf0e5xSzZWyt3sSd0=ANhh_LA@mail.gmail.com>
 <alpine.DEB.2.02.1202291205270.18906@heelrod.ad.cirrus.com>
 <CAAL8m4yDQRdp5Ar+GoNHsD1_pmBGToF9qbapAhWAvHnOM0Dg9w@mail.gmail.com>
 <alpine.DEB.2.02.1203071437480.3784@heelrod.ad.cirrus.com> <alpine.DEB.2.02.1203071456040.3784@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35992 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751976Ab2CHGOI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 01:14:08 -0500
Received: by lahj13 with SMTP id j13so146792lah.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 22:14:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1203071456040.3784@heelrod.ad.cirrus.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

On Thu, Mar 8, 2012 at 2:26 AM, Brian Austin <brian.austin@cirrus.com> =
wrote:
> On Wed, 7 Mar 2012, Brian Austin wrote:
>
>> On Thu, 1 Mar 2012, Govindraj wrote:
>>
>>> On Wed, Feb 29, 2012 at 11:36 PM, Brian Austin <brian.austin@cirrus=
=2Ecom>
>>> wrote:
>>>>
>>>> Applying this patch gives this on my beagleboard xM revC
>>>>
>>>> Linux debian 3.3.0-rc4
>>>>
>>>> Unable to set up timer: unexpected error
>>>> Failed to bring up eth0.
>>>
>>>
>>> Works for me on 3.3-rc4 + sent patch on beagle xm revc
>>>
>>> here this the log [1]
>>>
>>> Ensure you have selected following for ehci
>>> and usb Ethernet adapter support.
>>>
>>> CONFIG_USB_EHCI_HCD
>>> CONFIG_USB_EHCI_HCD_OMAP
>>> CONFIG_USB_NET_SMSC95XX
>>>
>> Thanks for the config.
>>
>> Unfortunately this does nothing for Debian Unstable on the beagleboa=
rd Xm
>> RevC
>
>
> I should rephrase this. =A0It does actually show up in the kernel log=
 so the
> kernel sees the device. =A0My bad. =A0It just wont grab an IP from De=
bian.


Thanks for the clarification.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
