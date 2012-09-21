From: Tony Lindgren <tony@atomide.com>
Subject: Re: gpmc_cs_request() causes early boot hang
Date: Fri, 21 Sep 2012 16:13:12 -0700
Message-ID: <20120921231312.GO28835@atomide.com>
References: <505CBFAA.3080604@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <505CBFAA.3080604@mimc.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Mark Jackson <mpfj-list@mimc.co.uk> [120921 12:29]:
> I'm developing a beaglebone cape board which requires the use of a
> GPMC chip select.
> 
> I've chosen GPMC_CS0, and in board-am335xevm.c, I have added the following:-
> 
> static void gpmc_test()
> {
>     unsigned long base = 0x12345678;
>     gpmc_cs_request(0, SZ_16M, &base);
>     printk(KERN_INFO "gpmc base @ 0x%08lx\n", base);
> }
> 
> ... and added a call to gpmc_test() at the end of am335x_evm_init().
> 
> If I try to run this code, the kernel fails to boot, and simply hangs at:-
> 
> Uncompressing Linux... done, booting the kernel.
> 
> If I comment out the call to gpmc_cs_request(), the system boots as
> expected (but without my required cs).
> 
> I've looked at the use of this call in other board files, and can't
> see that their code does anything special so I'm stuck on why this
> simple code fails to work.
> 
> Can anyone shed light on what I'm doing wrong ?
> 
> Do I have to initialise the gpmc beforehand in some way ?

Can you enable DEBUG_LL + EARLYPRINTK and have earlyprintk in your
cmdline? You may then get some error messages providing more info.

GPMC is working on many boards with various devices like smsc911x,
onenand, tusb etc.

Regards,

Tony
