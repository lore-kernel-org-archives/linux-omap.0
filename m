From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH v2 2/3] [OMAP] Add spi100k configuration to OMAP1
Date: Sat, 9 Jan 2010 09:14:36 -0800
Message-ID: <6cb013311001090914r219cfb48i4797631900f0871a@mail.gmail.com>
References: <1260668088-27555-1-git-send-email-darkstar6262@gmail.com>
	<1260668088-27555-3-git-send-email-darkstar6262@gmail.com>
	<20100106191946.GB11511@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:55717 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab0AIRO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jan 2010 12:14:57 -0500
Received: by pwj9 with SMTP id 9so626928pwj.21
        for <linux-omap@vger.kernel.org>; Sat, 09 Jan 2010 09:14:57 -0800 (PST)
In-Reply-To: <20100106191946.GB11511@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Wed, Jan 6, 2010 at 11:19 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like the driver is in mainline, so let's try to make it working..
>
> I've updated your patch to just check the return value of ioremap instead
> of BUG_ON. I've also merged it with the mux patch, see below. Can you
> please try it out and make sure everything is OK?
>

Just finished testing it -- with the one fix in device.c that's
covered in a different email thread, the changes work perfectly.

- Cory
