From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 04:50:44 -0700
Message-ID: <386072610804070450h1204f563t2842dd85909caf9c@mail.gmail.com>
References: <386072610804070344n7533b618n3abaf360ed1c7919@mail.gmail.com>
	 <3a8523948b12e55c004a5422c4d60944@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:37100 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623AbYDGLur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 07:50:47 -0400
Received: by gv-out-0910.google.com with SMTP id s4so152082gve.37
        for <linux-omap@vger.kernel.org>; Mon, 07 Apr 2008 04:50:45 -0700 (PDT)
In-Reply-To: <3a8523948b12e55c004a5422c4d60944@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com

>  >
>  > I just don't understand why they are OK on Linux host PC and failed on
>  > Linux Host embedded MUSB OTG.
>
>  PCs have to source up to 500mA load on usb bus, embedded otg/hosts only up
>  to 100mA.
>
>

After digging into to hardware manual of our Blackfin BF54x EZKIT
board, I think it can support up to 500 mA as it claimed and designed:
P1-22 of ADSP-BF548 EZ-KIT Lite Evaluation System Manual
http://www.analog.com/UploadedFiles/Associated_Docs/70955664ADSP_BF548_EZ_KIT_Lite_Manual_Rev_1_1.pdf
---
The ADSP-BF548 processor has a built-in, high-speed USB on-the-go
(OTG) interface and integrated PHY. This interface connects to a
24 MHz clock (U13), has surge protection, and can be configured as a host
or device. When in device mode, the USB 5V regulator (VR1) and FET
switch (U39) are turned OFF. When in host mode, the USB 5V regulator
and FET are turned ON and can supply 5V at 500 mA.
---

And they use this external regular to provide this:
http://www.analog.com/en/prod/0,,766_818_ADP3336,00.html

So one of the reason is the whole 500 mA providing method does not
work, I just guess.
I will contact with the hardware guy internally.

Thanks
-Bryan
