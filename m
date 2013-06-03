From: jgq516@gmail.com
Subject: Re: keystone2 board hangs with smp kernel
Date: Mon, 03 Jun 2013 11:47:20 +0800
Message-ID: <51AC11C8.3020009@gmail.com>
References: <51ABFD0B.3020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:65526 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab3FCDr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Jun 2013 23:47:26 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so5020477pbb.41
        for <linux-omap@vger.kernel.org>; Sun, 02 Jun 2013 20:47:26 -0700 (PDT)
Received: from [128.224.163.23] ([1.202.252.122])
        by mx.google.com with ESMTPSA id lq4sm60970307pab.19.2013.06.02.20.47.23
        for <linux-omap@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 20:47:25 -0700 (PDT)
In-Reply-To: <51ABFD0B.3020701@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Oops, I forgot to load boot monitor code before run smp kernel.

Regards,
Xiao

On 06/03/2013 10:18 AM, jgq516@gmail.com wrote:
> Hello Cyril,
>
> I have got one TI keystone2 board, and tried different tags of tree: 
> git://arago-project.org/git/projects/linux-keystone.git,
> but seems the kernel always hangs as follows, and kernel runs ok if 
> add "nosmp" flag.
>
> [    0.028386] CPU: Testing write buffer coherency: ok
> [    0.032493] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.037108] hw perfevents: enabled with ARMv7 Cortex-A15 PMU 
> driver, 7 counters available
> [    0.043763] Setting up static identity map for 0x80464628 - 0x8046465c
>
> The uboot version which I used is from 
> git://arago-project.org/git/projects/u-boot-keystone.git
> with tag DEV.MCSDK-2013-01.10, I also tried other tags, but seems no 
> different effect.
>
> Could you give some advice about smp problem? Thanks in advance!
>
> Regards,
> Xiao

