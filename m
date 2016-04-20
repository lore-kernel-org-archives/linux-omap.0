From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 20 Apr 2016 11:58:23 +0300
Message-ID: <571744AF.5030008@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
 <20160413212500.GD5995@atomide.com> <5710B58C.7050108@ti.com>
 <20160415120942.3131eac1@bbrezillon> <5710C86A.9060108@ti.com>
 <20160415135108.63716f06@bbrezillon> <20160415154139.GS5995@atomide.com>
 <20160415180531.15d790d2@bbrezillon> <20160415161950.GT5995@atomide.com>
 <20160416105711.5310d2d0@bbrezillon> <5714D3A4.2050405@ti.com>
 <5714D8AA.9040304@ti.com> <20160418151305.17a42437@bbrezillon>
 <5714E5AA.5050200@ti.com> <20160418161001.2a1c0bed@bbrezillon>
 <5714F185.5080103@ti.com> <20160418165755.77d1d661@bbrezillon>
 <5716289B.4060302@ti.com> <20160419221129.59b559fb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160419221129.59b559fb@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 19/04/16 23:11, Boris Brezillon wrote:
> On Tue, 19 Apr 2016 15:46:19 +0300
> Roger Quadros <rogerq@ti.com> wrote:
> 
>>
>> After all the changes we discussed in [1] I was able to test nand/next-with-gpmc-rework
>> and it worked fine.
>>
>> [1] - http://thread.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/22596/focus=22936
>>
>> I'd be happy to test the branch again after you've incorporated all changes.
> 
> Just pushed what's supposed to be my new nand/next into
> nand/next-with-gpmc-rework, can you test it? I'll push it to nand/next
> once I have your confirmation that everything is good.
> 

Tested this on dra7-evm, am437x-gp-evm and omap3-beagle and all seems good. Thanks :).

cheers,
-roger
