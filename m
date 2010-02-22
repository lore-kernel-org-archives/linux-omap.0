From: "Anna, Suman" <s-anna@ti.com>
Subject: RE: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
Date: Mon, 22 Feb 2010 14:14:22 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640E02663@dlee04.ent.ti.com>
References: <2C1563023E232C49B9F505633D57C2DA2640D0235C@dlee04.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF8C@dbde02.ent.ti.com>
 <7E59F0E987E71F40A4E30590884852DC01725109D4@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47533 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135Ab0BVUO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 15:14:26 -0500
In-Reply-To: <7E59F0E987E71F40A4E30590884852DC01725109D4@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

Hi Benoit,

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Sunday, February 21, 2010 7:36 AM
> To: Shilimkar, Santosh; Anna, Suman; linux-omap@vger.kernel.org
> Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A, Subramaniam
> Subject: RE: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> 
> Hi Suman,
> 
> >
> Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve
> Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
> 
> -----Original Message-----
> 
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> >Sent: Saturday, February 20, 2010 7:53 PM
> >To: Anna, Suman; linux-omap@vger.kernel.org
> >Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A, Subramaniam
> >Subject: RE: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >owner@vger.kernel.org] On Behalf Of Anna,
> >> Suman
> >> Sent: Friday, February 19, 2010 2:37 AM
> >> To: linux-omap@vger.kernel.org
> >> Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A,
> Subramaniam
> >> Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> >>
> >> From 2488815a9facca29e2da3ddd279de441a5de6a58 Mon Sep 17 00:00:00 2001
> >> From: Suman Anna <s-anna@ti.com>
> >> Date: Tue, 26 Jan 2010 16:55:29 -0600
> >> Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> >>
> >> OMAP4 mailbox has a different register set. There is
> >> no MAILBOX_SYSSTATUS register. The reset is indicated
> >> with the SOFTRESET bit of the MAILBOX_SYSCONFIG register
> >> itself. This bit should read 0 for a successful Reset.
> >> Also, the SOFTRESET bit occupies bit0 and not bit1 as with
> >> previous generations.

> 
> This is due to the new standard defined for OMAP4 IPs and well explain by
> Thara in a recently posted patch to handle that smoothly using hwmod.
> [PATCH V4] OMAP3: hwmod: support to specify the offset position of various
> SYSCONFIG register bits.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg23509.html
> 
> Is there a reason to not convert the mailbox driver to use hwmod?
> It will avoid you to handle that in the mailbox driver code, whereas the
> hwmod framework is already taking care of that.
> 
> Regards,
> Benoit
>

Thanks for the reference. Mailbox driver is yet to migrate to use the new hwmod. It is still based on the old framework.

Regards
Suman
 
