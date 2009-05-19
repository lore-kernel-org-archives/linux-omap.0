From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: Remove IRQ hardcoding from serial.c
Date: Tue, 19 May 2009 09:52:24 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CB709@dbde02.ent.ti.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
 <20090507204653.GD5593@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B4688409@dbde02.ent.ti.com>
 <20090508151755.GI5593@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B48440F9@dbde02.ent.ti.com>
 <20090518214539.GT19742@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbZESEWb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 00:22:31 -0400
In-Reply-To: <20090518214539.GT19742@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Tuesday, May 19, 2009 3:16 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: Remove IRQ hardcoding from serial.c
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090513 07:53]:
> > Tony,
> > Any comments on this patch.
> > http://patchwork.kernel.org/patch/19161/
> 
> We should just set the interrupts etc dynamically using the
> cpu_is_omapXXXX() functions.
That's indeed a good idea. But then are we going to remove this information from platform structures. If not then hardcoding is still bad and should be removed.

Regards,
Santosh
 