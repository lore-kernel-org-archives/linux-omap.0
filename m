From: "Simon Braunschmidt" <sbraunschmidt.linuxlists@googlemail.com>
Subject: android bringup on 3430sdp
Date: Wed, 16 Apr 2008 12:04:57 +0200
Message-ID: <1ee641e10804160304q7c18917aqf78e784f34be5ec2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:57466 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbYDPKE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 06:04:58 -0400
Received: by an-out-0708.google.com with SMTP id d31so651163and.103
        for <linux-omap@vger.kernel.org>; Wed, 16 Apr 2008 03:04:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anils@mistralsolutions.com, linux-omap@vger.kernel.org
Cc: arthur.mielimonka@teleca.com

Dear Anil

I have read your mail on linux-omap regarding android bringup and i
face the same problem here:

# strace -f -ff -tt -s 200 /system/bin/app_process
18:04:58.941997 execve("/system/bin/app_process",
["/system/bin/app_process"], [/* 7 vars */]) = 0
18:04:58.992902 getpid()                = 197
18:04:58.993919 syscall_983045(0xb0015cb0, 0xb00128d8, 0x3d4, 0,
0xbe922ec8, 0x1, 0, 0xf0005, 0xb00128d8, 0, 0, 0xbe922ec4, 0,
0xbe922e78, 0xb0000dd9, 0xb00016fc, 0x10, 0xb0015cb0, 0, 0, 0xc764, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
18:04:58.995114 gettid()                = 197
18:04:58.996091 --- SIGSEGV (Segmentation fault) @ 0 (0) ---
18:04:58.997169 +++ killed by SIGSEGV +++
Process 197 detached
#

Did you find out how get around that problem? Unfortunately i have no
idea atm...

Regards,
Simon Braunschmidt
