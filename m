From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2: Camera: Add OMAP2 24xx camera driver.
Date: Mon, 5 Mar 2007 15:56:10 +0530
Message-ID: <5d5443650703050226u6d935f99ufbcf213be4c0f236@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47622854@dlee13.ent.ti.com>
	<45EBE1F0.4070108@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45EBE1F0.4070108@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 3/5/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
>
> > Can you please give some insight into this DMA split?
>
> I did the DMA split to reduce the mess. I also think the new interface
> offered by the DMA code is better. DMA is split to scatter-gather DMA,
> individual DMA channels and DMA hardware handling. Accesses to different
> logical parts are fairly clearly visible (e.g. container_of stuff). And
> it's out of the main driver. The splitting into files could be of course
> different, but I have to say like some things in Java. ;)

I think there is no problem in getting 3k plus lines of code as single
driver file into upstream. smc91x.c alone is 2300+ lines of code.

>
> But indeed if there's a general DMA framework that could be used, then I
> suppose that's the way to go eventually.
>

MMU/MBox (IVA/DSP/Cam) framework like approach can be used. Something
like "SysDMA" and "CamDMA" as two separate instances of similar or may
be slightly different hardware blocks.

-- 
--Trilok Soni
