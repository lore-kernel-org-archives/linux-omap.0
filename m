From: Francisco Alecrim <alecrim@gmail.com>
Subject: Re: problem with n810 boot up
Date: Wed, 06 Jan 2010 19:59:48 -0400
Message-ID: <4B4523F4.7080504@gmail.com>
References: <200912290152.16357.luke@dashjr.org> <20100106224520.GA29239@gandalf> <4B45167F.8020605@gmail.com> <201001061740.17161.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:43838 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213Ab0AFX74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 18:59:56 -0500
Received: by yxe26 with SMTP id 26so17185450yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 15:59:55 -0800 (PST)
In-Reply-To: <201001061740.17161.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

Hi Luke,

Luke-Jr wrote:
> On Wednesday 06 January 2010 05:02:23 pm you wrote:
>> I'm using the flags (no-omap-wd,no-retu-wd,no-lifeguard-reset)
>> recommended by Kalle[1]. This's not the problem. :(
> 
> AFAIK, no-retu-wd disables *pinging* the retu WD (which itself cannot be 
> disabled). I'd try removing that one.

I tried with/without no-retu-wd, no-omap-wd .
> 
> Also, note my rootfs is Gentoo, not Maemo. Maemo will depend on DSME which is 
> not being started with my modded linuxrc.

I'm using Mamona. Anyway,I did some tests before rootfs execution and I
got the same problem. My current init contain only "exec /bin/sh".
Device just turn power-off without error message.  :(

Thanks anyway,
Alecrim.


