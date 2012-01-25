From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
 suspend is not implemented
Date: Tue, 24 Jan 2012 21:16:33 -0800
Message-ID: <CAN8TOE9hw8_qRd2CmkHr2eDAsbjbspD6gwQ7wpU-2skJTty-AQ@mail.gmail.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
	<1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
	<CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
	<20120124090630.GR16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48141 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab2AYFQe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 00:16:34 -0500
Received: by wgbed3 with SMTP id ed3so4833650wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 21:16:33 -0800 (PST)
In-Reply-To: <20120124090630.GR16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Artem Bityutskiy <dedekind1@gmail.com>

On Tue, Jan 24, 2012 at 1:06 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 24, 2012 at 12:09:04AM -0800, Brian Norris wrote:
>> However, the bug made it into the 3.3 merge window, so shouldn't thi=
s
>> bugfix be sent upstream immediately?
>
> David is the MTD maintainer, and Artem just helps out. =A0I believe A=
rtem
> is waiting for David to finish travelling before asking David (last s=
een
> at Hong Kong airport) to pull these fixes. =A0David in turn will pass=
 them
> onto Linus. =A0Plus, Linus only started adding to -rc1 yesterday, so =
its a
> little early to expect this to be fixed.

Right, thanks for the reality check. I was just ensuring that this
bugfix was on the right track. I probably should have said "in
3.3-rcX", not "immediately."

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
