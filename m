From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: About to tag 2.6.23-omap1
Date: Tue, 23 Oct 2007 17:29:59 +0200
Message-ID: <471E1377.401@googlemail.com>
References: <20071023011920.GL17318@atomide.com>
	<9c9fda240710221845y341a5cb0i50b7e07e6d959853@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9c9fda240710221845y341a5cb0i50b7e07e6d959853@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kyungmin Park wrote:
> There is a pending patch related with OMAP2 USB device DMA support.
> I think now there's one user to use this feature, Apollon.
> 
> As David's comment, it has board specific code.
> but the DMA patch don't update the board specific code. it only adds
> the DMA codes.
> 
> So if you don't mind I hope to merge this one too.

Looking into my pending patches list, I think you mean

http://linux.omap.com/pipermail/linux-omap-open-source/2007-October/011579.html

?

Dirk

> Thank you,
> Kyungmin Park
> 
> On 10/23/07, Tony Lindgren <tony@atomide.com> wrote:
> 
>>Hi all,
>>
>>I'm planning to tag 2.6.23-omap1 tomorrow morning PST with current
>>linux-omap git tree unless somebody comes up with fixes that still
>>should go in.
>>
>>So only fixes right now please, then let's update the tree to
>>mainline kernel, and try to get most of the pending patches such as
>>mmc, v4l, osk-2420, omap2-nand etc applied (and fixed if needed).
>>
>>After that, let's plan on doing the move of arch/arm/plat-omap/dsp
>>to drivers/dsp/omap. And then we prepare patches do the fixes needed
>>for Russell for plat-omap and mach-omap1 before 2.6.24-rc5 to try to
>>get them mostly in sync with mainline. Then we can hopefully sync up
>>mach-omap2 for 2.6.25-rc5.
>>
>>Cheers,
>>
>>Tony
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
