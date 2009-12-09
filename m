From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [APPLIED] [PATCH v3] omap: serial: fix non-empty uart fifo read
 abort
Date: Wed, 9 Dec 2009 19:47:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFBF7@dbde02.ent.ti.com>
References: <1259972404-28784-1-git-send-email-vikram.pandita@ti.com>
 <notify-1260224602@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFA1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35053 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911AbZLIORO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 09:17:14 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFA1C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>

> 
> With current Linus' tree + this patch, I can boot up on 3630.
> 
> Playing with the omap3_defconfig now, to see how many boards
> we can boot up with a single image :)
> 

I got a zoom2, zoom3, 3430SDP and 3630 SDP booting with a
single image.

I had to disable Profiling and Sound support to get it to
build with this config. Will post a patch after -rc1 if this
is not resolved by then.


- Anand
