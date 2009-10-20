From: Brett Graham <graham@rowland.harvard.edu>
Subject: mmap /dev/mem in python
Date: Tue, 20 Oct 2009 18:06:31 -0400
Message-ID: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:60210 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbZJTWGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 18:06:47 -0400
Received: by ewy3 with SMTP id 3so5357321ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 15:06:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm trying to mmap /dev/mem in python to access various registers on a
gumstix overo (with an omap 3530 processor). Here is the code I'm
using (as a minimal example):
----------------------------
import os, mmap
MAP_MASK = mmap.PAGESIZE - 1
addr = (see below)

f = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)
m = mmap.mmap(f, mmap.PAGESIZE, mmap.MAP_SHARED, mmap.PROT_WRITE |
mmap.PROT_READ, offset=addr & ~MAP_MASK)
m.seek(addr & MAP_MASK)
c = m.read_byte()
print c
m.close()
os.close(f)
----------------------------

If I use: addr = 0x48002178 everything works swimmingly. However, if I
use: addr = 0x48088024 (or all the addresses I've tried > 0x48044000)
I get the following error

Unhandled fault: external abort on non-linefetch (0x1018) at 0x40020024
Bus error

and python crashes. I'm basing the mmap flags and options off of
devmem2.c. If I remove the O_SYNC flag from the os.open command, I can
read and write to registers fine, but randomly I will get the
Unhandled fault error and things will not work correctly.

Am I using the right command to write to the omap registers? should I
be using the O_SYNC flag? Any ideas where these errors are coming
from?

Thanks in advance for your help.
