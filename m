From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 13:13:49 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290253046F@dlee13.ent.ti.com>
References: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>, Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

> I was reading OMAP3 TRM and I couldn't find the offset of PRCM
> register at memory maps. In OMAP2 I can clearly see PRCM there... also
> in omap34xx.h there's no such definition, even though we need it in
> order to build support for USB OTG.
>=20
> How should I handle it ?? probably we're gonna need to change
> something in arch/arch/mach-omap2/mmu.c ??

Can you clarify that?

mmu.c is something used with the DSP MMU.  I don't see the intersection =
with USB-OTG with that.

For OMAP3 the PRCM (power/reset/clock/manager) has been split into a PM =
(power/manager) and a CRM (clock/reset/manager).  They now live in a =
couple address spaces instead of one.  This allows the CRM to be moved =
into a space which can be powered down when CORE is in OFF mode.  The PM =
is in the wake power domain.

You will find the CM at 0x48004000 on and the PRM at 0x48306000 on.  The =
voltage controller and smart reflex registers are at 0x480C9000 on.

Regards,
Richard W.
