From: Bryan Wu <bryan.wu@canonical.com>
Subject: Passing mem=1G to kernel on Panda, system is unstable.
Date: Wed, 12 Jan 2011 00:52:23 +0800
Message-ID: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f66.google.com ([209.85.216.66]:44800 "EHLO
	mail-qw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab1AKQwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 11:52:45 -0500
Received: by qwk3 with SMTP id 3so6505299qwk.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 08:52:44 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Hi folks,

We are trying to build kernel package or GCC natively on OMAP4 panda
board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35 based
kernel, we met same instabilities on the system when we try to use
mem=3D1G on the board.

Please find our bug tracker here:
https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/633227
and I think another bug is also related:
https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/690370.
System will freeze at all when building GCC natively on Panda.

Did any folks meet this issue? or we need more simple test case to
catch the root cause of this issue.

Thanks a lot,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
