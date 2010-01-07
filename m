From: Francisco Alecrim <alecrim@gmail.com>
Subject: Re: problem with n810 boot up
Date: Thu, 07 Jan 2010 11:25:40 -0400
Message-ID: <4B45FCF4.5030409@gmail.com>
References: <200912290152.16357.luke@dashjr.org> <201001061740.17161.luke@dashjr.org> <4B4523F4.7080504@gmail.com> <201001061810.49763.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:60005 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab0AGPZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 10:25:48 -0500
Received: by gxk3 with SMTP id 3so7678966gxk.1
        for <linux-omap@vger.kernel.org>; Thu, 07 Jan 2010 07:25:46 -0800 (PST)
In-Reply-To: <201001061810.49763.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

Luke-Jr wrote:
> On Wednesday 06 January 2010 05:59:48 pm you wrote:
>> Luke-Jr wrote:
>>> Also, note my rootfs is Gentoo, not Maemo. Maemo will depend on DSME
>>> which is not being started with my modded linuxrc.
>> I'm using Mamona. Anyway,I did some tests before rootfs execution and I
>> got the same problem. My current init contain only "exec /bin/sh".
>> Device just turn power-off without error message.  :(
> 
> Well, give me a place to push my git tree and try that :)

If you have some custom changes to linux-omap kernel work correctly with
N8x0+Gentoo, you can share it using http://gitorious.org/ . It's gonne
be nice!
