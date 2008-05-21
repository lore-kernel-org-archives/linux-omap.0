From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Thu, 22 May 2008 04:01:17 +0530
Message-ID: <a1d91fa0805211531l65795e64lb8817f5f1444b11b@mail.gmail.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com>
	 <20080521154010.GY23002@atomide.com>
	 <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com>
	 <20080521174426.GC23002@atomide.com>
	 <db841a1287fea2504e17c787c8e25940@felipebalbi.com>
	 <20080521204822.GD23002@atomide.com>
	 <a1d91fa0805211516y2651ce64u1930681831871f64@mail.gmail.com>
	 <3ad3e5a4917933bd1b610345fc9326cc@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:56585 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076AbYEUWbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 18:31:19 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1677209tic.23
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2008 15:31:17 -0700 (PDT)
In-Reply-To: <3ad3e5a4917933bd1b610345fc9326cc@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

# cat /proc/tty/drivers
/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
serial               /dev/ttyS       4 64-67 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master
pty_slave            /dev/ttyp       3 0-255 pty:slave
pty_master           /dev/pty        2 0-255 pty:master
unknown              /dev/tty        4 1-63 console

this is the output..

regards and thanx,
shareef

On Thu, May 22, 2008 at 3:51 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Thu, 22 May 2008 03:46:37 +0530, "mohammed shareef"
> <mdshareef@gmail.com> wrote:
>> when i type:
>>
>> ls -l /dev/ttyS0
>> crw-rw-rw-    1 root     root       4,  64 Aug  8  2004
>> \0x1b[1;35m/dev/ttyS0\0x1b[0m
>> # ls -l /dev/ttyS1
>> -rw-r--
>
> ...
>
> that's a bit weird. What does cat /proc/tty/drivers show ?
>
> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
>
