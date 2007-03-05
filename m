From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH] ARM: OMAP2: Camera: Add OMAP2 24xx camera driver.
Date: Mon, 05 Mar 2007 11:25:04 +0200
Message-ID: <45EBE1F0.4070108@nokia.com>
References: <9C23CDD79DA20A479D4615857B2E2C47622854@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47622854@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "ext Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Syed Mohammed, Khasim wrote:
> I am yet to review this patch completely. One immediate topic that I
> want to bring up is about DMA files. In Jian's code to David and Komal
> he had DMA driver integrated into camera driver and David moved the DMA
> part to new file. Which according to me was an OK one, but in your patch
> set I see around 3 DMA related files. I really don't see a necessity for
> this split. 
> 
> If you really want to clean up the DMA part of it then its better to
> upgrade the dma.c file for OMAP2, the CAM_DMA and system_DMA are same.
> Why not add this functionality there? Or use the existing DMA
> functionality instead of duplicating the code.
> 
> Also, looking at the future Camera work for 3430 I feel this DMA
> framework is definitely going totally different (FYI there is no
> integrated CAM DMA in ISP). We have to use MMU here and we are looking
> at adopting Trilok's and DOYU-san's MMU framework.

I haven't looked at the 3430 spec yet, but the MMU should be used on 
2420 as well. Is it different on 3430? The current allocation of 
memory-mapped buffers is a hack...

> Can you please give some insight into this DMA split?

I did the DMA split to reduce the mess. I also think the new interface 
offered by the DMA code is better. DMA is split to scatter-gather DMA, 
individual DMA channels and DMA hardware handling. Accesses to different 
logical parts are fairly clearly visible (e.g. container_of stuff). And 
it's out of the main driver. The splitting into files could be of course 
different, but I have to say like some things in Java. ;)

But indeed if there's a general DMA framework that could be used, then I 
suppose that's the way to go eventually.

-- 
Sakari Ailus
sakari.ailus@nokia.com
