From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] mtd: davinci-nand: disable subpage write for
 davinci-nand
Date: Tue, 3 Jan 2017 14:13:46 +0100
Message-ID: <20170103141346.5e652afe@bbrezillon>
References: <1457428095-2801-1-git-send-email-sushaanth.s@ti.com>
        <20170103095918.7da43be3@bbrezillon>
        <e51292a6-15a5-ce5b-da7b-dbd22ede38b6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e51292a6-15a5-ce5b-da7b-dbd22ede38b6@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Cooper Jr., Franklin" <fcooper@ti.com>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sekhar,

On Tue, 3 Jan 2017 17:07:44 +0530
Sekhar Nori <nsekhar@ti.com> wrote:

> Hi Boris,
> 
> On Tuesday 03 January 2017 02:29 PM, Boris Brezillon wrote:
> > Hi Sushaanth,  
> 
> Sushaanth is not with TI anymore. You might have received a bounce.

Indeed.

> 
> > 
> > Sorry for the late reply, I'm dequeing old NAND related patches and
> > found this one.
> > 
> > Is this patch still needed?  
> 
> I dont think so. I suspect the real root cause was addressed by Karl in 
> commit f6d7c1b5598b ("mtd: nand: davinci: Reinitialize the HW ECC 
> engine in 4bit hwctl")

Okay, cool. I'll just mark the patch as 'Superseeded' in patchwork.

> 
> I just ran mtd_subpagetest on my da850 lcdk board and it passed[1]. If 
> there are more tests to run to determine if subpage write really works, 
> let me know too.

No, that should be good.

> 
> I suspect even the original workaround for keystone boards may not be 
> needed after Karl's patch. I will test and send a patch dropping the 
> workaround altogether if the tests succeed.

Sounds good.

Thanks,

Boris
