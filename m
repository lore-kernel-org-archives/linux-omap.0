From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 04:31:11 -0700
Message-ID: <386072610804070431n69a518f1na5493633a7c9986d@mail.gmail.com>
References: <386072610804070344n7533b618n3abaf360ed1c7919@mail.gmail.com>
	 <3a8523948b12e55c004a5422c4d60944@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:30307 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbYDGLbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 07:31:16 -0400
Received: by ug-out-1314.google.com with SMTP id z38so450173ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 07 Apr 2008 04:31:12 -0700 (PDT)
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

Maybe it is one explanation for these bugs.
I found the bug usb device:
USB SD card reader MaxPower = 250mA
Apple 30G iPod MaxPower = 500mA

But the latest 80G iPod Classic which also has MaxPower = 500mA works
fine with MUSB.

For this current source problem, I remember there are some external
VBUS charger IC can help the USB OTG to provide more than 100mA
current.

-Bryan
