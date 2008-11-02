From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [beagleboard] can't boot Linux-2.6.28-rc2-omap1
Date: Sun, 2 Nov 2008 05:43:57 +0200
Message-ID: <94a0d4530811012043i3cce4198kfdd69c2f8f368508@mail.gmail.com>
References: <d82e647a0811011947i6ab62cf6w463ea462ce49183c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:35450 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbYKBDn6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 23:43:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1977727rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 01 Nov 2008 20:43:57 -0700 (PDT)
In-Reply-To: <d82e647a0811011947i6ab62cf6w463ea462ce49183c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com
Cc: linux-omap@vger.kernel.org

On Sun, Nov 2, 2008 at 4:47 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>
> Hi All,
>
> I am working on testing Linux-2.6.28-rc2 omap kernel on beagle board, and uImage
> is compiled from linux-omp git tree in the following way:
>
>     export  CROSS_COMPILE=arm-none-linux-gnueabi-
>     make distclean
>     make  omap3_beagle_defconfig
>     make uImage
>
> Then the boot messages :
>
> -------------------------------------------------------------
>    OMAP3 beagleboard.org # mmcinit;fatload mmc 0 0x80300000 ui3
> reading ui3
>
> 1723104 bytes read
> OMAP3 beagleboard.org # bootm 0x80300000
> ## Booting kernel from Legacy Image at 80300000 ...
>   Image Name:   Linux-2.6.28-rc2-omap1-05147-g82
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    1723040 Bytes =  1.6 MB
>   Load Address: 80008000
>   Entry Point:  80008000
>   Verifying Checksum ... OK
>   Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux...................................................................................
> ............................ done, booting the kernel.
> --------------------------------------------------------------
> and it stucks at here.

I'm getting the same =/

-- 
Felipe Contreras
