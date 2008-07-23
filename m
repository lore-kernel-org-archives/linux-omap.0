From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver board/device setup for
 OMAP3430
Date: Wed, 23 Jul 2008 02:32:30 -0500
Message-ID: <3db54da6fc6e74db523cc8e6bd2cf69d@felipebalbi.com>
References: <38309.192.168.10.89.1216727733.squirrel@dbdmail.itg.ti.com> <1473aac0380c8c62329714e83f6ca795@felipebalbi.com> <002301c8ec7f$1405df30$37f6180a@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56577 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYGWHcb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 03:32:31 -0400
In-Reply-To: <002301c8ec7f$1405df30$37f6180a@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Mikko.K.Ylinen@nokia.com



On Wed, 23 Jul 2008 10:16:27 +0530, "Madhusudhan Chikkature"
<madhu.cr@ti.com> wrote:
> Hi Felipe,
> 
>> Tony, weird that we still have these prototypes in these headers.
>> Could be some merging conflict ?
> Yes. I see that these prototypes are still present in the board3430 and
> board2430 header files in the omap tree.
> 
>> Anyways, please apply the attached patch. We're using
>> usb_musb_init() and usb_ehci_init() now.
> You mean I should apply the attached patch you sent for local use, right?
> And I guess I dont need to resend this perticular BCI patch, am I
correct?

No :-)

that was to Tony. Just replied to your mail so it's easy to see why we need
that patch :-)

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

