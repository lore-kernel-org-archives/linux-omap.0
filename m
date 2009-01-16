From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 01/10] omap mailbox: cleanup omap2 register definition
 with macro
Date: Fri, 16 Jan 2009 14:15:24 +0200 (EET)
Message-ID: <20090116.141524.236287675.Hiroshi.DOYU@nokia.com>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
	<20090116082706.17571.31102.stgit@oreo.research.nokia.com>
	<25e057c00901160156w6058ade2j9c99ef727d8767ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18502 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080AbZAPMPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 07:15:43 -0500
In-Reply-To: <25e057c00901160156w6058ade2j9c99ef727d8767ab@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: roel.kluin@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

From: "ext roel kluin" <roel.kluin@gmail.com>
Subject: Re: [PATCH 01/10] omap mailbox: cleanup omap2 register definition with macro
Date: Fri, 16 Jan 2009 10:56:01 +0100

[...]
> > +#define MAILBOX_SYSCONFIG              0x010
> > +#define MAILBOX_SYSSTATUS              0x014
> > +#define MAILBOX_MESSAGE(m)             (0x040 + 4 * (m))
> > +#define MAILBOX_FIFOSTATUS(m)          (0x080 + 4 * (m))
> > +#define MAILBOX_MSGSTATUS(m)           (0x0c0 + 4 * (m))
> > +#define MAILBOX_IRQSTATUS(u)           (0x100 + 8 * (u))
> > +#define MAILBOX_IRQENABLE(u)           (0x108 + 8 * (u))
>                                                                   ^^^^^^^
> shouldn't this be
> #define MAILBOX_IRQENABLE(u)           (0x104 + 8 * (u))

Right. I'll fix, thanks.
