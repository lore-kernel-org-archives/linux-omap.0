From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: fix default sys_ck.rate for boot-time
	DPLLdetection
Date: Mon, 22 Oct 2007 07:37:09 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290249C536@dlee13.ent.ti.com>
References: <20071019211415.183990583@mvista.com>
	<1193037864.29349.261.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <1193037864.29349.261.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Igor Stoppa <igor.stoppa@nokia.com>, ext Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The TI code does this with init_osc_sys_clk_rates() function.  The
preset bit in structure likely isn't needed.

The APLLS field which is setup by the bootloader is used to know osc and
sys clk's rates.

A little while back Paul had patched some of this and the initial go did
result in a bad value for this.  After this was pointed out a subsequent
patch was pushed to fix this.  Perhaps yet another patch broke this or
perhaps the version you are using was missing this update.

Regards
Richard W.


>=20
> Hi Kevin,
> On Fri, 2007-10-19 at 14:14 -0700, ext Kevin Hilman wrote:
> > In the clock init code, the DPLL value set by the bootloader is
> > queried, but always turns zero due it's parent clock (sys_ck) having
> > no default rate.  This results in the improper setting of the
default
> > PRCM rate-table entry and any queries of virt_prcm_set rate to
return 0.
> >
> > Following the example of the TI kernel, set the default sys_ck rate
to
> > 13MHz.  Could then be overridden in board setup code.
>=20
> There should be an even cleaner way to handle that (but i have no code
> to prove that it works =3D) since the boot rom already does
auto-detection
> of the oscillator to support serial flashing.
>=20
> If it is possible to read the detected value then the code can be
moved
> to arch or even plat.
>=20
> --
> Cheers, Igor
>=20
> Igor Stoppa <igor.stoppa@nokia.com>
> (Nokia Multimedia - CP - OSSO / Helsinki, Finland)
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
