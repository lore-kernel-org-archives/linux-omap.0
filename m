From: "Heilpern, Mark" <mark.heilpern@authentec.com>
Subject: RE: SPI support working?
Date: Tue, 23 Oct 2007 15:53:07 -0400
Message-ID: <5ACCFDF5BCF2C34DB62D54EFA1FDF700479D89@corp-mail01.auth.org>
References: <20071023011920.GL17318@atomide.com><9c9fda240710221845y341a5cb0i50b7e07e6d959853@mail.gmail.com><471E1377.401@googlemail.com><20071023174000.GH5193@atomide.com>
	<5ACCFDF5BCF2C34DB62D54EFA1FDF700479D31@corp-mail01.auth.org>
	<3B6D69C3A9EBCA4BA5DA60D9130274290249CFD8@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290249CFD8@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard,

Thanks much for the response. It sounds to me like exploring the "McSPI
library helper" may be my best option, if this is a kernel mode library
that can be included in a loadable module. The work I'm doing is on a
prototype board, and when it reaches the end user's hardware it will be
on an even older kernel (2.6.18), so anything I can do to not require
kernel changes would be for the best.

I'll talk to my local TI rep to see if I can get some FAE support.

> BTW: Are you the same Mark who wrote the OS9 Primer?
Not much use for the Primer these days, but it's been on my shelf for
about 12 years now. I look more-or-less the same as the picture on the
back, sans beard. Nice to hear from you and to see you're at TI. I
recognized your name as soon as I saw it in email; it's a small world.

Mark




-----Original Message-----
From: Woodruff, Richard [mailto:r-woodruff2@ti.com]=20
Sent: Tuesday, October 23, 2007 3:43 PM
To: Heilpern, Mark; linux-omap-open-source@linux.omap.com
Subject: RE: SPI support working?

Hello,

> I'm new to OMAP Linux, and on a project I'm working on I need to use
it
> to implement SPI. I'm using an OMAP 2430 board that brings SPI2 out to
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
> Is anyone using SPI on an OMAP these days? Am I going to have to
manage
> my own register driver rather than being able to rely on something
> already written? Can I simply rip these definitions from a different
> kernel source base and use them (along with fixing the function call
> issues, of course)?

A couple paths exist here.

The omap-git tree is using a nice and relatively newer SPI frame work.
It would have the most community usage probably against OMAP2420 not
OMAP2430.  Making it work on 2430 should be doable, especially using
some example working TI code.  It might be someone already has it going.

On the TI website in example kernels, a McSPI library helper
implementation as opposed to the newer driver exists.  This would have
been tested and will work against the older kernel version on reference
hardware.  Drivers will call these helpers to get work done.

TI does have some newer version as used with OMAP3430 which is jumping
to use the new frame work.  This kernel through some TI channels (FAE)
likely can be made available, or after some delay it likely will be
posted on TI's website, and will eventually show up in the community
omap-git.

Regards,
Richard W.

BTW: Are you the same Mark who wrote the OS9 Primer?


NOTE: The information in this message is intended for the personal and =
confidential use
of the designated recipient(s) named above. To the extent the =
recipient(s) is/are bound
by a non-disclosure agreement, or other agreement that contains an =
obligation of
confidentiality, with AuthenTec, then this message and/or any =
attachments shall be
considered confidential information and subject to the confidentiality =
terms of that
agreement.  If the reader of this message is not the intended recipient =
named above, you
are notified that you have received this document in error, and any =
review, dissemination,
distribution or copying of this message is strictly prohibited. If you =
have received this
document in error, please delete the original message and notify the =
sender immediately.
Thank you.

AuthenTec, Inc.  http://www.authentec.com
