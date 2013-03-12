From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 1/1] Fix sprz319 erratum 2.1
Date: Tue, 12 Mar 2013 10:50:45 -0500
Message-ID: <CAOCHtYivQAf=sHc_m3D83-jLkZCkkf0ZcCdMdwXS=Qma-2B--A@mail.gmail.com>
References: <4F4289C2.90707@kynesim.co.uk>
	<CAOd_LFzegrdpJ9W_DDGCVJrCtdm6bsvAwEg5o1g6+Tjb2EMCjQ@mail.gmail.com>
	<alpine.DEB.2.00.1303121456230.25871@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33868 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab3CLPuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 11:50:46 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so6602451ied.16
        for <linux-omap@vger.kernel.org>; Tue, 12 Mar 2013 08:50:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303121456230.25871@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Cliff Brake <cliff.brake@gmail.com>, Richard Watts <rrw@kynesim.co.uk>, paul@pswan.com, linux-omap@vger.kernel.org

>> Has any more testing been done with this?  We're running into a
>> situation where the USB subsystem crashes in a beagleboard xM after
>> running for a couple hours to a day.  A USB camera is running
>> continuously during this time.  The error message typically something
>> like:
>>
>> [ 2817.415710] hub 1-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
>> [ 2817.422607] usb 1-2: USB disconnect, device number 2
>> [ 2817.427886] usb 1-2.1: USB disconnect, device number 3
>> [ 2817.441986] usb 1-2.4: USB disconnect, device number 4
>> [ 2817.450134] usb 1-2.5: USB disconnect, device number 5
>
> Are you in a position to test whether the patch works for you?
>
> I'd still like to find someone whose USB problem is fixed by the patch and
> is willing to try a slight modification of it before applying...

HI Paul,

I just recently traded with one of our customers for his "bad" xM.  If
you have something, I'm always running on mainline kernel's..

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
