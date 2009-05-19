From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: slab corruption
Date: Tue, 19 May 2009 13:58:16 +0300 (EEST)
Message-ID: <20090519.135816.27795453.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E60292F45E00@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36112 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZESK6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 06:58:47 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E60292F45E00@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: h-kanigeri2@ti.com, grgupta@ti.com, nm@ti.com, omar.ramirez@ti.com, p-kargirwar@ti.com, linux-omap@vger.kernel.org

Hi Fernand,

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: slap corruption
Date: Tue, 19 May 2009 03:56:08 +0200

> 
> 
> 
> Hi everyone,
> 
> We have been looking into the Slab Corruption error and we have found the problem occurs after an application has been terminated abnormally, e.g. Using CTL-C or Segmentation Fault or kill.
> 
> The issue is observed not only for DMM test cases but for others test cases that don't use DMM.
> 
> The problem is reported by 'slab.c' when a slab object which is inactive, it supposed to be filled with POISON_FREE (6b) and has some 00 within the object, this seems to be corrupted.
> 
> Slab corruption: size-64 start=c6bc71e0, len=64
> <3>Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> <3>Last user: [<bf063464>]Last user: [<bf063464>](MEM_Free+0x9c/0xe0 [bridgedriv
> er])(MEM_Free+0x9c/0xe0 [bridgedriver])
> 
> <3>010:010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  6b 00 00 00 00 00 00 00 00
> 
> 
> it seems it is not being freed correctly, because instead of being filled only with 6b it has 00 maybe other process is overwriting it.
> 
> Does anyone have any idea of what can be happening?

We've seen this kind of problem with gst-launch. It seems that you can
reproduce the problem with more simple operation.

Would it be possible to tell us how to reproduce the problem?

If you can with one of dsp sample applications, it's quite useful.


> 
> Regards,
> Fernando.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
