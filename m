From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: SPI support working?
Date: Tue, 23 Oct 2007 14:43:08 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290249CFD8@dlee13.ent.ti.com>
References: <20071023011920.GL17318@atomide.com><9c9fda240710221845y341a5cb0i50b7e07e6d959853@mail.gmail.com><471E1377.401@googlemail.com><20071023174000.GH5193@atomide.com>
	<5ACCFDF5BCF2C34DB62D54EFA1FDF700479D31@corp-mail01.auth.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <5ACCFDF5BCF2C34DB62D54EFA1FDF700479D31@corp-mail01.auth.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Heilpern, Mark" <mark.heilpern@authentec.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

> I'm new to OMAP Linux, and on a project I'm working on I need to use =
it
> to implement SPI. I'm using an OMAP 2430 board that brings SPI2 out to =
a
> header, and the vendor kernel is at version 2.6.19. Applying their
> board-specific patch to a 2.6.22 source base (after applying
> patch-2.6.22-omap1, of course) resulted in a large number of patch
> rejects.
>=20
> So far I haven't been able to build a kernel with OMAP McSPI support
> enabled in it; there have been errors that suggest this stuff has not
> recently been compiled... wrong number of arguments to a function
> (omap_set_dma_dest_params) and numerous macros undefined anywhere
> (OMAP24XX_DMA_SPI[12]_[TR]X[123]).
>=20
> Is anyone using SPI on an OMAP these days? Am I going to have to =
manage
> my own register driver rather than being able to rely on something
> already written? Can I simply rip these definitions from a different
> kernel source base and use them (along with fixing the function call
> issues, of course)?

A couple paths exist here.

The omap-git tree is using a nice and relatively newer SPI frame work.  =
It would have the most community usage probably against OMAP2420 not =
OMAP2430.  Making it work on 2430 should be doable, especially using =
some example working TI code.  It might be someone already has it going.

On the TI website in example kernels, a McSPI library helper =
implementation as opposed to the newer driver exists.  This would have =
been tested and will work against the older kernel version on reference =
hardware.  Drivers will call these helpers to get work done.

TI does have some newer version as used with OMAP3430 which is jumping =
to use the new frame work.  This kernel through some TI channels (FAE) =
likely can be made available, or after some delay it likely will be =
posted on TI's website, and will eventually show up in the community =
omap-git.

Regards,
Richard W.

BTW: Are you the same Mark who wrote the OS9 Primer?
