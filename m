From: Raju Sana <venkat.rajuece-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: McSPI questions pertaining to GPIO chip select support
Date: Tue, 30 Aug 2011 15:44:22 +0530
Message-ID: <CA+dZkakw9COsETWZkvMzp2v-ymfQdDEqp3jJuhWbrRTTTjpbGQ@mail.gmail.com>
References: <1264016711-sup-309@ben-laptop>
	<1264651770-sup-5197@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1264651770-sup-5197@ben-laptop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, beagleboard <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ben,

Could you please post your patch as I am also working the similar design.
I need to modify the existing McSPI driver to support 3 codec chips.

Thanks.
Venkat Raju.


On Thu, Jan 28, 2010 at 9:40 AM, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hey all!
>
> Recently I've been thinking about adding support to the McSPI driver for
> using GPIO pins as chip selects. As a starting point, I've browsed the
> driver source trying to identify what changes would be necessary to add
> this support. It seems like the rough idea is,
>
>  a) add a cs_gpio field to the device struct (omap2_mcspi)
>  b) modify omap2_mcspi_force_cs() to use cs_gpio instead of the
>     CHxCONF[FORCE] bit if cs_gpio is valid
>
> Unfortunately, I'm having a bit of difficulty seeing how the existing
> configuration works. In master mode, it seems that the controller is
> configured in single forced channel mode (MCSPI_MODULECTRL_SINGLE).  As
> far as I can tell, this means that the driver is responsible for
> managing the chip selects through the MCSPI_CHxCONF[FORCE] bits. It
> seems that this is ideal as little will need to be changed to
> incorporate GPIO CS support.
>
> Nevertheless, the timing of the various operations isn't making sense to
> me. As far as I understand it, the callgraph is as follows,
>
>
> omap2_mcspi_work():
>  loop over messages
>    omap2_mcspi_set_enable(1)
>    loop over transfers:
>      configure bus parameters
>      if (!cs_active) cs = 1
>      if (dma):
>        omap2_mcspi_txrx_dma()
>      else:
>        omap2_mcspi_txrx_pio()
>      if (cs_change) cs = 0
>    end loop
>
>    if (cs_active) cs = 0
>    omap2_mcspi_set_enable(0)
>  end loop
>
>
> It seems that omap2_mcspi_set_enable() is called to enable the channel
> (MCSPI_CHCTRLx[EN] is set) before force_cs() is called. If I'm
> interpreting the hardware documentation correctly, the enable bit (among
> other things) starts the SPI clock, meaning that the chip will begin
> clocking out zeros to the device before CS is brought high.
> Furthermore, even after CS is brought high, it seems there could be a
> fair amount of time before the chip begins actually clocking out valid
> data.
>
> As I am writing this, it now occurs to me that perhaps the chip doesn't
> start SPI_CLK until it has data to send. It seems that if this were the
> case my concerns would be resolved. However, it is not at all clear that
> this is the case from the documentation. When exactly does the
> controller start the bus clock? Is this stated explicitly anywhere in
> the documentation?
>
> Any input you could offer would be greatly appreciated.
> Thanks for your time.
>
> - Ben
>
>
> P.S. The more and more I think about it, it seems like my hypothesis is
> the only logical behavior. It would be great if someone could confirm my
> suspicions, however. It really seems like this should be in the
> documentation either way.
>
> P.P.S. I apologize if this is something someone familiar with SPI should
> just know. My knowledge is a little spotty on this sort of thing.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
