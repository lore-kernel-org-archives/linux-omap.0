From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
	use ldrex/strex
Date: Mon, 24 Jan 2011 14:11:12 +0000
Message-ID: <20110124141112.GM16202@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk> <20110123001636.GA20841@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101222323190.8580@xanadu.home> <20110123093526.GA26120@n2100.arm.linux.org.uk> <AANLkTi=tpnNXm8w9-VFi72nYvXRQV5-jE7Qn9NNk1wLW@mail.gmail.com> <AANLkTinnQLsa4mOV+SLYxeRrwZdc8N36SW9pK6ne+6TQ@mail.gmail.com> <20110124102849.GA18459@n2100.arm.linux.org.uk> <AANLkTikmwDkdiAPoCx+Oz7qhTbpuOTHeam9gSi=WesSa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46486 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab1AXOL2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 09:11:28 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikmwDkdiAPoCx+Oz7qhTbpuOTHeam9gSi=WesSa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 07:17:54PM +0530, Poddar, Sourav wrote:
> On Mon, Jan 24, 2011 at 3:58 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jan 24, 2011 at 02:27:24PM +0530, Poddar, Sourav wrote:
> >> On Mon, Jan 24, 2011 at 2:08 PM, Poddar, Sourav <sourav.poddar@ti.=
com> wrote:
> >> > On Sun, Jan 23, 2011 at 3:05 PM, Russell King - ARM Linux
> >> > <linux@arm.linux.org.uk> wrote:
> >> >> On Sat, Jan 22, 2011 at 11:44:59PM -0500, Nicolas Pitre wrote:
> >> >>> At least another person did post results:
> >> >>>
> >> >>> http://mid.gmane.org/20110117094602.GA2622@pulham.picochip.com
> >> >>> http://mid.gmane.org/20110117110308.GC2622@pulham.picochip.com
> >> >>
> >> >> Slightly different patch - there were three revisions. =A0I can=
't attach
> >> >> a tested-by given to a different patch to this one.
> >> >>
> >> >>> > That means omap2plus_defconfig .38 mainline kernels
> >> >>> > (including -stable) will remain potentially dangerous when r=
un on
> >> >>> > SMP capable hardware.
> >> >>>
> >> >>> I must admit that this series looks a bit large for stable IMH=
O. =A0I
> >> >>> think that the fix for stable should limit itself only to prev=
ent SMP
> >> >>> from being selected if anything else than CPU_32v6K is selecte=
d.
> >> >>
> >> >> The first three are the bare minimum required for -stable.
> >> >>
> >> >
> >>
> >> =A0Boot tested the 14 patch series =A0with CONFIG_SWP_EMULATE enab=
led, on
> >> =A0the following boards :
> >>
> >>
> >> =A0 1. Omap2420 SDP
> >>
> >> =A0 2. Omap2430 SDP
> >>
> >> =A0 3. Omap3430 SDP
> >>
> >> =A0 4. Omap4 Blaze
> >>
> >> =A0 Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> >
> > Thanks. =A0It's also important to ascertain which filesystems were =
tested -
> > could you let me know please?
> >
>=20
> It is a custom filesystem on BusyBox v1.17.2.

So you wrote code under fs/ for this filesystem?

> Please let me know if you need some other
> information.

I'm trying to find out what _type_ of filesystem.  ext2, ext3, nfs, cra=
mfs,
etc.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
