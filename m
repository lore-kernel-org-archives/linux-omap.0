From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Passing mem=1G to kernel on Panda, system is unstable.
Date: Fri, 14 Jan 2011 13:42:58 +0530
Message-ID: <641ab84b6cedfd62b9b6bedeae077f1b@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49929 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752068Ab1ANINC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 03:13:02 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so2530224fxm.35
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 00:12:59 -0800 (PST)
In-Reply-To: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Bryan,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Bryan Wu
> Sent: Tuesday, January 11, 2011 10:22 PM
> To: linux-omap@vger.kernel.org; Ricardo Salveti de Araujo
> Subject: Passing mem=1G to kernel on Panda, system is unstable.
>
> Hi folks,
>
> We are trying to build kernel package or GCC natively on OMAP4 panda
> board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35 based
> kernel, we met same instabilities on the system when we try to use
> mem=1G on the board.
>
> Please find our bug tracker here:
> https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/633227
> and I think another bug is also related:
> https://bugs.launchpad.net/ubuntu/+source/linux-ti-
> omap4/+bug/690370.
> System will freeze at all when building GCC natively on Panda.
>
> Did any folks meet this issue? or we need more simple test case to
> catch the root cause of this issue.
>
Haven't seen this issue on my SDP with 2.6.37.
Have you enabled HIGHMEM, when tried mem = 1G on 2.6.37 ?
