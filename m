From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Wed, 21 May 2008 17:21:05 -0500
Message-ID: <3ad3e5a4917933bd1b610345fc9326cc@felipebalbi.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com> <20080521154010.GY23002@atomide.com> <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com> <20080521174426.GC23002@atomide.com> <db841a1287fea2504e17c787c8e25940@felipebalbi.com> <20080521204822.GD23002@atomide.com> <a1d91fa0805211516y2651ce64u1930681831871f64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47899 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134AbYEUWVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 18:21:09 -0400
In-Reply-To: <a1d91fa0805211516y2651ce64u1930681831871f64@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com



On Thu, 22 May 2008 03:46:37 +0530, "mohammed shareef"
<mdshareef@gmail.com> wrote:
> when i type:
> 
> ls -l /dev/ttyS0
> crw-rw-rw-    1 root     root       4,  64 Aug  8  2004
> \0x1b[1;35m/dev/ttyS0\0x1b[0m
> # ls -l /dev/ttyS1
> -rw-r--

...

that's a bit weird. What does cat /proc/tty/drivers show ?

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

