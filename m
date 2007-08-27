From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock
 autoidlingviathe clock framework
Date: Mon, 27 Aug 2007 01:56:10 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0708270139510.17118@utopia.booyaka.com>
References: <20070820095347.933473149@pwsan.com><20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
	<3E32F84CD6CB95498A35B353CA3B930C0672EE@fioues08.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3E32F84CD6CB95498A35B353CA3B930C0672EE@fioues08.ebgroup.elektrobit.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tuukka.Tikkanen@elektrobit.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 23 Aug 2007, Tuukka.Tikkanen@elektrobit.com wrote:

> One minor detail to note is that on OMAP2 the sleep code sometimes has
> to disable the autoidle feature on certain clocks. Not doing so would
> prevent desired functionality. This - at least the action of setting the
> autoidle state - of course could be handled via the clock framework.
> However, it was deemed to be unnecessary extra layer, as the sleep code
> already has to be very aware of the hardware its running on and any
> abstraction is useless. I think at least timers and DMA have some
> special restrictions in pm.c. Thus the original design of PM code
> handling the autoidle bits.

Hi Tuukka,

I took a quick look at pm.c, it configures ICLK autoidling for SDMA and 
GPT*, and sleep.S doesn't look like it touches the autoidle regs. Could 
you point me at the code you're talking about?

thanks,

- Paul
