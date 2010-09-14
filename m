From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAPFB query
Date: Tue, 14 Sep 2010 17:10:14 +0300
Message-ID: <1284473414.2522.93.camel@tubuntu.research.nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F70C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38884 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab0INOKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 10:10:31 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F70C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-09-14 at 16:00 +0200, ext Janorkar, Mayuresh wrote:
> Hi!
> 
> For OMAPFB we have two header files:
> drivers/video/omap2/omapfb/omapfb.h
> include/linux/omapfb.h
> 
> There are some definitions like: 
> #define FB2OFB(fb_info) ((struct omapfb_info *)(fb_info->par))
> 
> This is not available in include/linux/omapfb.h
> 
> Can anybody help me in understanding how a user space application can use these definitions in omap2/omapfb/omapfb.h

I have no idea what you are trying to do, but those are kernel internal
definitions, so you can't use them. You can't even include
drivers/video/omap2/omapfb/omapfb.h, it's a kernel internal header file.

 Tomi


