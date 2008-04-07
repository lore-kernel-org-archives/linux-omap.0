From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old
	iPod will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 20:50:28 +0300
Message-ID: <20080407175027.GB4464@kedavra.cpe.vivax.com.br>
References: <386072610804070344n7533b618n3abaf360ed1c7919@mail.gmail.com> <3a8523948b12e55c004a5422c4d60944@felipebalbi.com> <386072610804070431n69a518f1na5493633a7c9986d@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50932 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYDGRse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 13:48:34 -0400
Content-Disposition: inline
In-Reply-To: <386072610804070431n69a518f1na5493633a7c9986d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com

On Mon, Apr 07, 2008 at 04:31:11AM -0700, Bryan Wu wrote:
> >  >
> >  > I just don't understand why they are OK on Linux host PC and failed on
> >  > Linux Host embedded MUSB OTG.
> >
> >  PCs have to source up to 500mA load on usb bus, embedded otg/hosts only up
> >  to 100mA.
> >
> 
> Maybe it is one explanation for these bugs.
> I found the bug usb device:
> USB SD card reader MaxPower = 250mA
> Apple 30G iPod MaxPower = 500mA
> 
> But the latest 80G iPod Classic which also has MaxPower = 500mA works
> fine with MUSB.

Like i told you, this is just a string we manually put there. Some
manufacturers seem not to use it the right way and just put the max
possible, e.g. 500mA

> For this current source problem, I remember there are some external
> VBUS charger IC can help the USB OTG to provide more than 100mA
> current.

Do you have it in blackfin ?

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
