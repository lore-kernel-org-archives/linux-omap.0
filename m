From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 13:50:03 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429025304BF@dlee13.ent.ti.com>
References: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253046F@dlee13.ent.ti.com>
	<31e679430710251124w70f370c5of30b209eacbf8753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <31e679430710251124w70f370c5of30b209eacbf8753@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

 > PS: I have also MMU Framework selected... this is what's causing this
> error...

I see.

> > For OMAP3 the PRCM (power/reset/clock/manager) has been split into a =
PM
> (power/manager) and a CRM (clock/reset/manager).  They now live in a
> couple address spaces instead of one.  This allows the CRM to be moved
> into a space which can be powered down when CORE is in OFF mode.  The =
PM
> is in the wake power domain.
>=20
> hmmm... now I saw that... nice... but MMU FW will need modifications =
won't
> it??


Yes I suppose this file should change.

Actually, this file really only makes sense for a OMAP2420 build.  The =
code is used with the C55-DSP+IVA1(arm7)+MMU. OMAP2430 and OMAP3430 use =
a different DSP system with only the C6X.

If you want the DSP path to work today you need to use TI's DSP bridge =
code.  I expect anytime from say today to the next month for the code to =
be publicly available.

Regards,
Richard W.
