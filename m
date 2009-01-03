From: "arun c" <arun.edarath@gmail.com>
Subject: Communication protocol through PCI between host and target
Date: Sat, 3 Jan 2009 15:16:48 +0530
Message-ID: <c656a4d20901030146t4d894931v91dff04c3eabeb9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:35053 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbZACJqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2009 04:46:51 -0500
Received: by bwz14 with SMTP id 14so20783451bwz.13
        for <linux-omap@vger.kernel.org>; Sat, 03 Jan 2009 01:46:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-pci@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I am a newbie here please bear with me.

In my custom board the communication between host and target
should happen through PCI interface.

The target processor runs u-boot, and host processor is running linux.

The target devices will be accessed from the host by /dev nodes.

To reduce the workload on host all the target calls like
open, read ,write ,ioctl are passed directly to the target.

There will be a common PCI buffer between host
and target and target will take commands from this buffer
and execute. The result of executed API also will be put to a shared buffer
between host and target. [This is what I am planning to implement]

Anybody has come across similar sort of scenario?
Any ideas or any pointers will be highly appreciated.

Regards,
Arun C
