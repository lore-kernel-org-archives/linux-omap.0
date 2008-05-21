From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Wed, 21 May 2008 17:33:47 -0500
Message-ID: <17a6f274c137c6b1876f4e9c199adf64@felipebalbi.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com> <20080521154010.GY23002@atomide.com> <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com> <20080521174426.GC23002@atomide.com> <db841a1287fea2504e17c787c8e25940@felipebalbi.com> <20080521204822.GD23002@atomide.com> <a1d91fa0805211516y2651ce64u1930681831871f64@mail.gmail.com> <3ad3e5a4917933bd1b610345fc9326cc@felipebalbi.com> <a1d91fa0805211531l65795e64lb8817f5f1444b11b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56813 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYEUWdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 18:33:50 -0400
In-Reply-To: <a1d91fa0805211531l65795e64lb8817f5f1444b11b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com



On Thu, 22 May 2008 04:01:17 +0530, "mohammed shareef"
<mdshareef@gmail.com> wrote:
> # cat /proc/tty/drivers
> /dev/tty             /dev/tty        5       0 system:/dev/tty
> /dev/console         /dev/console    5       1 system:console
> /dev/ptmx            /dev/ptmx       5       2 system
> /dev/vc/0            /dev/vc/0       4       0 system:vtmaster
> serial               /dev/ttyS       4 64-67 serial

Here's what you're looking for.

> pty_slave            /dev/pts      136 0-1048575 pty:slave
> pty_master           /dev/ptm      128 0-1048575 pty:master
> pty_slave            /dev/ttyp       3 0-255 pty:slave
> pty_master           /dev/pty        2 0-255 pty:master
> unknown              /dev/tty        4 1-63 console
> 
> this is the output..

It seems ok, no idea why the 4 doesn't appear in ls -l.
Sorry :-s

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

