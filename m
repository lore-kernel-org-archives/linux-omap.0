From: jgq516@gmail.com
Subject: Re: keystone2 board hangs with smp kernel
Date: Mon, 03 Jun 2013 10:33:04 +0800
Message-ID: <51AC0060.40505@gmail.com>
References: <51ABFD0B.3020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:40918 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab3FCCdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Jun 2013 22:33:12 -0400
Received: by mail-pd0-f178.google.com with SMTP id w16so165256pde.9
        for <linux-omap@vger.kernel.org>; Sun, 02 Jun 2013 19:33:12 -0700 (PDT)
Received: from [128.224.163.23] ([1.202.252.122])
        by mx.google.com with ESMTPSA id nz3sm490620pbb.33.2013.06.02.19.33.07
        for <linux-omap@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 19:33:09 -0700 (PDT)
In-Reply-To: <51ABFD0B.3020701@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 06/03/2013 10:18 AM, jgq516@gmail.com wrote:
> Hello Cyril,
>
Oops seems Cyril has left TI since I got below infos.

Delivery to the following recipient failed permanently:

      cyril@ti.com

Technical details of permanent failure:
Google tried to deliver your message, but it was rejected by the server for the recipient domain ti.com by cluster5.us.messagelabs.com. [216.82.253.147].

The error that the other server returned was:
550 Invalid recipient<cyril@ti.com>  (#5.1.1)

Could someone else can help about that? Thanks.

Regards,
Xiao
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

