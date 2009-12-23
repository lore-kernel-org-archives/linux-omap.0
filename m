From: Steve Sakoman <sakoman@gmail.com>
Subject: serial port input corruption with 2.6.32?
Date: Wed, 23 Dec 2009 12:59:46 -0800
Message-ID: <5e088bd90912231259k12dfafeckecbaaa1d29cec4ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:42346 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbZLWU7r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 15:59:47 -0500
Received: by qyk30 with SMTP id 30so3552075qyk.33
        for <linux-omap@vger.kernel.org>; Wed, 23 Dec 2009 12:59:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm seeing some strange behavior with my console serial port with 2.6.3=
2.

Output seems fine -- no errors in the boot messages.

However it seems that quite often the first character typed in a
console session is garbled -- subsequent characters are OK:

root@omap3:~# =EF=BF=BDs -l
-sh: =EF=BF=BDs: not found

If commands are typed in rapid succession this issue doesn't show up,
but if several seconds pass since the last keystroke the first
character is garbled once again.

Anyone else seeing this?  A search of this list didn't turn anything
up, but perhaps my google mojo is just bad today.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
