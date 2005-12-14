From: Romain Goyet <r.goyet@gmail.com>
Subject: Some comments on Linux-OMAP tree by Russell King
Date: Wed, 14 Dec 2005 15:25:34 +0100
Message-ID: <8028e5750512140625n161c5c34u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: OMAP Linux mailing list <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello guys,
  I've had recently many problems on my Palm Tungsten E. In
particular, it was crashing when I ran "local_flush_tlb_all()", in
arch/arm/mm/init.c. I asked for help on the ARM-Linux mailing list,
and here is what Russell finally told me :

> Argh, omap sets up a mapping and then immediately tries to access
> IO space.  If some of the cache lines for the page tables were already
> in the cache, or you are using a write-alloc cache, that's not going
> to work - the mappings will not be visible to the MMU.  Note carefully
> the comment:
>
>       /*
>        * Finally flush the caches and tlb to ensure that we're in a
>        * consistent state wrt the writebuffer.  This also ensures that
>        * any write-allocated cache lines in the vector page are written
>        * back.  After this point, we can start to touch devices again.
>        */
>
> and omap is accessing devices _prior_ to that point. 8(
>
> This is most likely the reason why you're seeing boot failures.

What do you think about this ? In particular, I think he is talking about t=
his :
in arch/arm/mach-omap1/io.c

        /* We have to initialize the IO space mapping before we can run
         * cpu_is_omapxxx() macros. */

This is true, but we have to wait _as well_ that
mm/init.c:devicemaps_init() has terminated. I would have proposed a
patch, but it looks like many functions, like
omap_sram_init();
and
omap1_clk_init();
Use cpu_is_omapXXXX() functions.

Do you have any idea for a workaround ?

Thanks in advance

Romain Goyet.


By the way, Russell also added this :

> Hmm, I notice that omap folk are _still_ buggering up the MMC core in
> relation to mmc.c.  It'd also be nice of omap folk could conform to
> the agreed usage of clk_use/unuse vs clk_enable/disable as documented
> in the header file.  The clock framework *relies* on everyone following
> the rules.  Frustrated sigh.
