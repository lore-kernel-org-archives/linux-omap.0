From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] omapfb vsync support
Date: Mon, 27 Feb 2006 17:43:49 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5048ACBAA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Mathias Agopian <mathias@google.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Maybe we could simply disable the IRQ from the IRQ handler after a
> second or so if no client has requested a FBIO_WAITFORSYNC ioctl?
>=20
> That, combined with disabling the interrupt when a client closes the
> driver should take care of most cases.
>=20
> Alternatively, we could disable the IRQ each time, if it's not a too
> heavy operation?

Maybe just have a use count and decrement it in omapfb_wait_for_vsync()
at wake up time... If you know how many users are in your queue you
should know how many to decrement it by.  If a process is killed I'm not
sure how that plays out, the kernel likely just closes paths and
probably silently de-queues a process where ever it happens to be stuck.

Regards,
Richard W.
