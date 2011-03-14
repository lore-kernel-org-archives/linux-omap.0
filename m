From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from
 driver
Date: Mon, 14 Mar 2011 17:57:27 +0000
Message-ID: <4D7E5707.5030305@warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com> <4D76A164.2060801@ti.com> <20110308233820.GJ26463@atomide.com> <4D778873.4070308@ti.com> <20110309191115.GM26463@atomide.com> <20110314174209.GC7258@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55758 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab1CNR5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 13:57:34 -0400
Received: by wwa36 with SMTP id 36so5977258wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 10:57:33 -0700 (PDT)
In-Reply-To: <20110314174209.GC7258@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

On 03/14/2011 05:42 PM, Somebody in the thread at some point said:

Hi -

> It looks like this series can be rebased on v2.6.38-rc8
> and should merge just fine with what we have queued in
> omap-for-linus. I guess I forgot we already did the i2c-omap
> hwmod conversion last merge window :)
>
> Andy, please repost the related patches against v2.6.38-rc8 with
> the acks posted earlier.

Alright, I will do that with the reordered patch from Benoit and the 
change to BIT() instead of constants.  Thanks.

-Andy
