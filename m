From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP2 USB DMA support
Date: Wed, 31 Oct 2007 04:13:31 -0700
Message-ID: <20071031111331.GD31081@atomide.com>
References: <20071010033410.GA25402@party>
	<003401c80ed3$4647fb70$e1ac580a@swcenter.sec.samsung.co.kr>
	<200710142028.14685.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200710142028.14685.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com, kmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* David Brownell <david-b@pacbell.net> [071014 20:29]:
> On Sunday 14 October 2007, Kyungmin Park wrote:
> > Hi David Brownell,
> >=20
> > Are there any comments?
>=20
> Didn't know I was expected to comment.  :)
>=20
> I didn't test this myself, so I can't comment on those issues.
> And I don't have time to trace the details of the DMA changes
> either... it looks plausible though.
>=20
> Except for this bit at the end:
>=20
> > @@ -2555,7 +2580,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * (for more reliable=
 behavior)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ((!use_dma && (add=
r & USB_DIR_IN))
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0|| machine_is_omap_apollon()
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0|| (!use_dma && machine_is_omap_apollon())
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|| cpu_is_omap15xx())
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0dbuf =3D 0;
>=20
> Having board-specific logic for that seems clearly wrong.
> (And I never much liked that original bit either...)

Kyungmin, could you please move the dbuf value into platform data
and have it set in omap_otg_init() in plat-omap/usb.c so Dave
will be happy and we can get your patch integrated into Linus'
tree also?

Regards,

Tony
