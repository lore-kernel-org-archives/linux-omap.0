From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH] ARM errata, 430973: update the affected revisions
Date: Mon, 13 Apr 2015 09:28:09 -0700
Message-ID: <20150413162808.GZ18048@atomide.com>
References: <1418131842-6752-1-git-send-email-jhofstee@victronenergy.com>
 <54EE2453.9080301@myspectrum.nl>
 <552840A9.8070406@myspectrum.nl>
 <20150411075220.GK12732@n2100.arm.linux.org.uk>
 <5528E88C.4070107@myspectrum.nl>
 <20150413143941.GY18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44287 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081AbbDMQbe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Apr 2015 12:31:34 -0400
Content-Disposition: inline
In-Reply-To: <20150413143941.GY18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jeroen Hofstee <linux-arm@myspectrum.nl>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jeroen Hofstee <jhofstee@victronenergy.com>, Andreas =?utf-8?B?Qmllw59tYW5u?= <andreas.devel@googlemail.com>, robertcnelson@gmail.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150413 07:46]:
> * Jeroen Hofstee <linux-arm@myspectrum.nl> [150411 02:26]:
> > Hello Russell, +Tony,
> >=20
> > Thanks for taking the time to respond,
> >=20
> > On 11-04-15 09:52, Russell King - ARM Linux wrote:
> > >On Fri, Apr 10, 2015 at 11:29:13PM +0200, Jeroen Hofstee wrote:
> > >>On 25-02-15 20:36, Jeroen Hofstee wrote:
> > >>>On 09-12-14 14:30, Jeroen Hofstee wrote:
> > >>>>From: Jeroen Hofstee <linux-arm@myspectrum.nl>
> > >>>>
> > >>>>Update the list of revisions subject to this errata.
> > >>>>
> > >>>>Cc: Catalin Marinas <catalin.marinas@arm.com>
> > >>>>Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > >>>>Cc: Andreas Bie=C3=9Fmann <andreas.devel@googlemail.com>
> > >>>>Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> > >>>>---
> > >>>>I don't have access to the AT400/AT401/AT490 document, but
> > >>>>Andreas was kind enough to provide this information, see
> > >>>>https://www.mail-archive.com/u-boot@lists.denx.de/msg156620.htm=
l
> > >>>>
> > >>>>Resending from an address which is subscribed to the ML...
> > >>>>---
> > >>>>  arch/arm/Kconfig | 2 +-
> > >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > >>>>index 89c4b5c..a2202fa 100644
> > >>>>--- a/arch/arm/Kconfig
> > >>>>+++ b/arch/arm/Kconfig
> > >>>>@@ -1063,7 +1063,7 @@ config ARM_ERRATA_430973
> > >>>>      depends on CPU_V7
> > >>>>      help
> > >>>>        This option enables the workaround for the 430973 Corte=
x-A8
> > >>>>-      (r1p0..r1p2) erratum. If a code sequence containing an A=
RM/Thumb
> > >>>>+      (r1p0..r1p3, r1p7) erratum. If a code sequence containin=
g an
> > >>>>ARM/Thumb
> > >>>>        interworking branch is replaced with another code seque=
nce at
> > >>>>the
> > >>>>        same virtual address, whether due to self-modifying cod=
e or
> > >>>>virtual
> > >>>>        to physical address re-mapping, Cortex-A8 does not reco=
ver from
> > >>>>the
> > >>>
> > >No.  If you read the discussion that the OMAP people are having, i=
t is
> > >unclear whether r3p2 is actually affected by this errata or not.
> > I scanned through it, but that is a different issue it seems. This =
patch
> > only adds r1p3 and r1p7 to the documentation, since according to AR=
M
> > they are affected by this errata. Newer revision should not be affe=
cted
> > by this errata (or ARM reintroduced it).
> >=20
> > The patch is _not_ adding r3p2 as an affected version. And is also =
not
> > about how to deal with cores no longer needing this workaround.
>=20
> Right.. But it seems that having the aux ctrl register bit enabled
> without doing the flush btac part leads into a different set of
> issues.
> =20
> > >In the discussion with OMAP people, we've come up with a potential=
ly
> > >better solution to this, which is to rearrange the code so that on=
ly
> > >Cortex-A8 executes this workaround, and the BTB flush is always
> > >present (which Tony says fixes the problem.)
> >=20
> > The am3517 / r1p7 is a Cortex-a8 and is affected by this errata. I =
fail to
> > see why making this cortex-a8 specific will help anything about the=
 revision
> > not being mentioned in the help text. (unless the CONFIG option get=
s
> > completely
> > removed).
> > >Meanwhile, OMAP people are seeing about updating uboot to set/clea=
r
> > >the auxiliary control register bit appropriately for the revision =
of
> > >the core.
> > Well almost appropriately. [1] suggest "the bootloaders can be fixe=
d
> > Cortex-A8
> > revisions later than r1p2 to not set the IBE bit.". That should hav=
e been
> > r1p7 as
> > well.
> >=20
> > >In any case, adding the patch and suggesting people enable this fo=
r
> > >more Cortex-A8's (eg, non-OMAP) won't actually do anything in a
> > >multiplatform kernel.
> > >
> > Can you give an example of a r1p7 not needing the workaround?
>=20
> Do you have some pointer for the documentation mentioning r1p7 is
> affected? It is possible that the revision range is wrong.. But I'm
> more likely to believe it is correct and we're hitting a different
> problem.
>=20
> I'm hoping that with Russell's patch and my patch in the thread
> below, you don't necessarily need to enable 430973. That's these
> two patches:
>=20
> http://www.spinics.net/lists/arm-kernel/msg411433.html
> http://www.spinics.net/lists/arm-kernel/msg411038.html
>=20
> If what Russell and I are saying is correct, with the above two
> patches your system should behave properly with 430973 even if
> bit 6 in the aux ctrl register is set (or unset) by the bootloader.
>=20
> If r1p7 is behaves with bit 6 cleared and errata 430973 set, then
> we know r1p7 is unaffected by 430973.

Sorry let's take this part again:

If r1p7 is behaves with bit 6 cleared and errata 430973 _unset_,
then we know r1p7 is unaffected by 430973.

Regards,

Tony
 =20
> > http://www.spinics.net/lists/arm-kernel/msg411297.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
