From: Barry Song <21cnbao@gmail.com>
Subject: the Usage of ROM and RAM of Cortex-M3 on OMAP4
Date: Tue, 21 May 2013 18:04:24 +0800
Message-ID: <CAGsJ_4x+TC04ajK5DYV8CSvRk6xvnmATuj35ruetWjMgLAYcbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:44658 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab3EUKEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 May 2013 06:04:45 -0400
Received: by mail-qc0-f177.google.com with SMTP id e1so214941qcy.22
        for <linux-omap@vger.kernel.org>; Tue, 21 May 2013 03:04:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pandaboard@googlegroups.com, linux-omap@vger.kernel.org

Hi All,
typically on OMAP4, Cortex-A9 will load the Cortex-M3 firmware and let
M3 run from the firmware. for example, on Android, Linux kernel will
use remoteproc module to load ducati-m3-core0.xem3 of Ducati.
but after reading the datasheet of OMAP4, there are internal 16KB ROM
and 64KB RAM for Cortex-M3. And the ROM is bootable. I'd like to know
who is using the embedded ROM and RAM and how they use. and can the
Cortex-M3 boot from ROM directly by itself?

Thanks
barry
