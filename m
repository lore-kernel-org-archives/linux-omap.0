From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: Booting n8x0 on mainline without UART
Date: Tue, 22 Feb 2011 14:00:59 +0300
Message-ID: <AANLkTi=KcqNWKD9SEh2Z=cO-PRktjLvMjM5t_F68hWqQ@mail.gmail.com>
References: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44870 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab1BVLBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 06:01:00 -0500
Received: by iwn34 with SMTP id 34so420672iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 03:01:00 -0800 (PST)
In-Reply-To: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

> I'm trying to boot up the mainline kernel on an n800 device. I don't have
> a functional UART up and running - so I cannot see any console messages.
>
> Does anyone have instructions or pointers to any patches that may be
> needed to get the mainline linux kernel booting to the UI on this
> platform?
>
> Alternatively, is there a way to direct the boot logs to the LCD instead
> of the UART/ttyMTD?

You may run your kernel under gdb in qemu like

qemu-system-arm -M n810 -kernel linux-omap-2.6/arch/arm/boot/zImage -s

load symbols from your vmlinux with gdb command

symbol-file linux-omap-2.6/vmlinux

and at certain point break into gdb by ^C and dump system log buffer
with gdb command

dump memory kmsg.log log_buf log_buf+100000

-- 
Max
