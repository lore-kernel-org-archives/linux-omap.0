From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling
 viathe clock framework
Date: Mon, 27 Aug 2007 01:39:47 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0708270119440.17118@utopia.booyaka.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708210050330.5695@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD86A6@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708220312320.15587@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901B38ED9@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901B38ED9@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Richard,

On Wed, 22 Aug 2007, Woodruff, Richard wrote:

> Actually the patch as I sent it was completely self contained it was
> done that way just to be fast :)  Changing it to use the macros is no
> problem.

Cool.

> I'd probably shy away from using the clock frame work to turn on and off 
> each clock via name string though.  They would result way too much code.

Yeah, in the autoidle patch I added a clk_allow_idle_all() function that 
just walked down the clock list and called ->allow_idle() on each clock 
that had one.  This avoided the search by name string.  Nevertheless, I 
think I will set that patch aside for now, it's not critical; maybe we'll 
take another look at it after the 3430 clock code shows up.

> The OCP registers are in each modules address space.  An example of what
> I was talking about is GTP1.TIOCP_CFG:0x48318010.

Indeed, my mistake; not sure what register I was looking at when I wrote 
the earlier post.

> On OMAP3 if you are using software control methods you may need to set
> these in a particular way to ensure data has cleared before shutting
> down the module.  I don't expect control at this granularity makes sense
> for our typical usage, but if you are doing full hardware dependency for
> idling it is relevant.

Is this only if we set *_SYSCONFIG.AUTOIDLE to force-idle?


- Paul
