From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] mtd: davinci-nand: disable subpage write for davinci-nand
Date: Tue, 3 Jan 2017 17:07:44 +0530
Message-ID: <e51292a6-15a5-ce5b-da7b-dbd22ede38b6@ti.com>
References: <1457428095-2801-1-git-send-email-sushaanth.s@ti.com>
 <20170103095918.7da43be3@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170103095918.7da43be3@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Cooper Jr., Franklin" <fcooper@ti.com>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On Tuesday 03 January 2017 02:29 PM, Boris Brezillon wrote:
> Hi Sushaanth,

Sushaanth is not with TI anymore. You might have received a bounce.

> 
> Sorry for the late reply, I'm dequeing old NAND related patches and
> found this one.
> 
> Is this patch still needed?

I dont think so. I suspect the real root cause was addressed by Karl in 
commit f6d7c1b5598b ("mtd: nand: davinci: Reinitialize the HW ECC 
engine in 4bit hwctl")

I just ran mtd_subpagetest on my da850 lcdk board and it passed[1]. If 
there are more tests to run to determine if subpage write really works, 
let me know too.

I suspect even the original workaround for keystone boards may not be 
needed after Karl's patch. I will test and send a patch dropping the 
workaround altogether if the tests succeed.

Thanks,
Sekhar

[1]
# modprobe mtd_subpagetest dev=2                                                                                        

=================================================
mtd_subpagetest: MTD device: 2
mtd_subpagetest: MTD device size 536215552, eraseblock size 131072, page size 2048, subpage size 512, count of eraseblocks 4091, pages
 per eraseblock 64, OOB size 64
mtd_test: scanning for bad eraseblocks
mtd_test: block 4087 is bad
mtd_test: block 4088 is bad
mtd_test: block 4089 is bad
mtd_test: block 4090 is bad
mtd_test: scanned 4091 eraseblocks, 4 are bad
mtd_subpagetest: writing whole device
mtd_subpagetest: written up to eraseblock 0
mtd_subpagetest: written up to eraseblock 256
mtd_subpagetest: written up to eraseblock 512
mtd_subpagetest: written up to eraseblock 768
mtd_subpagetest: written up to eraseblock 1024
mtd_subpagetest: written up to eraseblock 1280
mtd_subpagetest: written up to eraseblock 1536
mtd_subpagetest: written up to eraseblock 1792
mtd_subpagetest: written up to eraseblock 2048
mtd_subpagetest: written up to eraseblock 2304
mtd_subpagetest: written up to eraseblock 2560
mtd_subpagetest: written up to eraseblock 2816
mtd_subpagetest: written up to eraseblock 3072
mtd_subpagetest: written up to eraseblock 3328
mtd_subpagetest: written up to eraseblock 3584
mtd_subpagetest: written up to eraseblock 3840
mtd_subpagetest: written 4091 eraseblocks
mtd_subpagetest: verifying all eraseblocks
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified up to eraseblock 256
mtd_subpagetest: verified up to eraseblock 512
mtd_subpagetest: verified up to eraseblock 768
mtd_subpagetest: verified up to eraseblock 1024
mtd_subpagetest: verified up to eraseblock 1280
mtd_subpagetest: verified up to eraseblock 1536
mtd_subpagetest: verified up to eraseblock 1792
mtd_subpagetest: verified up to eraseblock 2048
mtd_subpagetest: verified up to eraseblock 2304
mtd_subpagetest: verified up to eraseblock 2560
mtd_subpagetest: verified up to eraseblock 2816
mtd_subpagetest: verified up to eraseblock 3072
mtd_subpagetest: verified up to eraseblock 3328
mtd_subpagetest: verified up to eraseblock 3584
mtd_subpagetest: verified up to eraseblock 3840
mtd_subpagetest: verified 4091 eraseblocks
mtd_subpagetest: verifying all eraseblocks for 0xff
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified up to eraseblock 256
mtd_subpagetest: verified up to eraseblock 512
mtd_subpagetest: verified up to eraseblock 768
mtd_subpagetest: verified up to eraseblock 1024
mtd_subpagetest: verified up to eraseblock 1280
mtd_subpagetest: verified up to eraseblock 1536
mtd_subpagetest: verified up to eraseblock 1792
mtd_subpagetest: verified up to eraseblock 2048
mtd_subpagetest: verified up to eraseblock 2304
mtd_subpagetest: verified up to eraseblock 2560
mtd_subpagetest: verified up to eraseblock 2816
mtd_subpagetest: verified up to eraseblock 3072
mtd_subpagetest: verified up to eraseblock 3328
mtd_subpagetest: verified up to eraseblock 3584
mtd_subpagetest: verified up to eraseblock 3840
mtd_subpagetest: verified 4091 eraseblocks
mtd_subpagetest: writing whole device
mtd_subpagetest: written up to eraseblock 0
mtd_subpagetest: written up to eraseblock 256
mtd_subpagetest: written up to eraseblock 512
mtd_subpagetest: written up to eraseblock 768
mtd_subpagetest: written up to eraseblock 1024
mtd_subpagetest: written up to eraseblock 1280
mtd_subpagetest: written up to eraseblock 1536
mtd_subpagetest: written up to eraseblock 1792
mtd_subpagetest: written up to eraseblock 2048
mtd_subpagetest: written up to eraseblock 2304
mtd_subpagetest: written up to eraseblock 2560
mtd_subpagetest: written up to eraseblock 2816
mtd_subpagetest: written up to eraseblock 3072
mtd_subpagetest: written up to eraseblock 3328
mtd_subpagetest: written up to eraseblock 3584
mtd_subpagetest: written up to eraseblock 3840
mtd_subpagetest: written 4091 eraseblocks
mtd_subpagetest: verifying all eraseblocks
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified up to eraseblock 256
mtd_subpagetest: verified up to eraseblock 512
mtd_subpagetest: verified up to eraseblock 768
mtd_subpagetest: verified up to eraseblock 1024
mtd_subpagetest: verified up to eraseblock 1280
mtd_subpagetest: verified up to eraseblock 1536
mtd_subpagetest: verified up to eraseblock 1792
mtd_subpagetest: verified up to eraseblock 2048
mtd_subpagetest: verified up to eraseblock 2304
mtd_subpagetest: verified up to eraseblock 2560
mtd_subpagetest: verified up to eraseblock 2816
mtd_subpagetest: verified up to eraseblock 3072
mtd_subpagetest: verified up to eraseblock 3328
mtd_subpagetest: verified up to eraseblock 3584
mtd_subpagetest: verified up to eraseblock 3840
mtd_subpagetest: verified 4091 eraseblocks
mtd_subpagetest: verifying all eraseblocks for 0xff
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified up to eraseblock 256
mtd_subpagetest: verified up to eraseblock 512
mtd_subpagetest: verified up to eraseblock 768
mtd_subpagetest: verified up to eraseblock 1024
mtd_subpagetest: verified up to eraseblock 1280
mtd_subpagetest: verified up to eraseblock 1536
mtd_subpagetest: verified up to eraseblock 1792
mtd_subpagetest: verified up to eraseblock 2048
mtd_subpagetest: verified up to eraseblock 2304
mtd_subpagetest: verified up to eraseblock 2560
mtd_subpagetest: verified up to eraseblock 2816
mtd_subpagetest: verified up to eraseblock 3072
mtd_subpagetest: verified up to eraseblock 3328
mtd_subpagetest: verified up to eraseblock 3584
mtd_subpagetest: verified up to eraseblock 3840
mtd_subpagetest: verified 4091 eraseblocks
mtd_subpagetest: finished with 0 errors
=================================================
