From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH 1/1] omap3: add definition for CONTROL_CAMERA_PHY_CTRL
Date: Thu, 12 Jan 2012 11:30:39 -0600
Message-ID: <CAKnK67SNdQBbWf6TTqnPHWia10X-kCJu4PzTcoJA9QUDD-UiXw@mail.gmail.com>
References: <1323875656-17147-1-git-send-email-sakari.ailus@iki.fi>
 <20120108104339.GP9323@valkosipuli.localdomain> <alpine.DEB.2.00.1201110700220.31702@utopia.booyaka.com>
 <20120111230355.GU9323@valkosipuli.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:33611 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752751Ab2ALRbB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 12:31:01 -0500
Received: by mail-qy0-f169.google.com with SMTP id d17so1131762qcs.28
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 09:31:00 -0800 (PST)
In-Reply-To: <20120111230355.GU9323@valkosipuli.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

Hi Sakari,

On Wed, Jan 11, 2012 at 5:03 PM, Sakari Ailus <sakari.ailus@iki.fi> wro=
te:
> Hi Paul,
>
> On Wed, Jan 11, 2012 at 07:11:58AM -0700, Paul Walmsley wrote:
>> On Sun, 8 Jan 2012, Sakari Ailus wrote:
>>
>> > Hi Tony and Paul,
>> >
>> > On Wed, Dec 14, 2011 at 05:14:16PM +0200, Sakari Ailus wrote:
>> > > The register is used to configure the behaviour of the CSI-2 and=
 CCP-2
>> > > receivers. This register is available only in OMAP3630.
>> > >
>> > > The original patch was submitted by Vimarsh Zutshi.
>> > >
>> > > Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
>> > > ---
>> > > =A0arch/arm/mach-omap2/control.h | =A0 =A01 +
>> > > =A01 files changed, 1 insertions(+), 0 deletions(-)
>> > >
>> > > diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2=
/control.h
>> > > index d4ef75d..6a26a0d 100644
>> > > --- a/arch/arm/mach-omap2/control.h
>> > > +++ b/arch/arm/mach-omap2/control.h
>> > > @@ -183,6 +183,7 @@
>> > > =A0#define OMAP3630_CONTROL_FUSE_OPP120_VDD1 =A0 =A0 =A0 (OMAP2_=
CONTROL_GENERAL + 0x0120)
>> > > =A0#define OMAP3630_CONTROL_FUSE_OPP50_VDD2 =A0 =A0 =A0 =A0(OMAP=
2_CONTROL_GENERAL + 0x0128)
>> > > =A0#define OMAP3630_CONTROL_FUSE_OPP100_VDD2 =A0 =A0 =A0 (OMAP2_=
CONTROL_GENERAL + 0x012C)
>> > > +#define OMAP3630_CONTROL_CAMERA_PHY_CTRL (OMAP2_CONTROL_GENERAL=
 + 0x02f0)
>> >
>> > I assume this patch hasn't gone anywhere yet which might be good. =
While the
>> > definition of this register would appear to belong to this file, i=
t is being
>> > included from the OMAP 3 ISP driver, which only uses it if it's ru=
nning on
>> > the 3630. The problem is that control.h isn't apparently intended =
to be
>> > included except locally and I didn't find a suitable file under in=
clude/mach
>> > to put this definition either. Currently this file is being includ=
ed by the
>> > ISP driver with an explicit path.
>> >
>> > Do you have an insight how this could be handled better?
>>
>> We've been trying to ensure that register accesses to/from a given I=
P
>> block only occur in a driver for that IP block. =A0So under that pri=
nciple,
>> any System Control Module accesses should go into a System Control M=
odule
>> driver. =A0Then that SCM driver should export (via EXPORT_SYMBOL) a
>> higher-level interface to whatever code uses it. =A0The idea is that=
 this
>> interface would remain stable no matter what underlying SoC was in u=
se.
>>
>> Only thing is, we don't yet have a SCM driver. =A0Historically, sinc=
e the
>> SCM is tightly coupled with the underlying SoC, when we've needed to=
 do
>> something like this in the past, we've added code to
>> arch/arm/mach-omap2/control.c. =A0But that's not really workable now=
=2E
>>
>> Do you know if this register, or something like it, is present on la=
ter
>> OMAPs? =A0Also, which bitfields are you planning to use?
>
> I don't believe it exists on other OMAPs --- possibly on 3730 but the=
 CSI-2
> receiver is not officially supported on it. The register does not exi=
st on
> the 3430, at least not under the same name --- a reason for not exist=
ing
> could be that the 3430 only has one CSI-2 receiver. The 4430 doesn't =
seem to
> have it either, at least not under that name.

In 4430/4460, there's CONTROL_CAMERA_RX (physical address:
0x4A100608), but it's not
exactly compatible.

There are some similar bit fields, but in different bit offsets:

3630 has these:
- [3:2] R_CONTROL_CAMERA1_PHY_CAMMODE
- [1:0] R_CONTROL_CAMERA2_PHY_CAMMODE

And 4430/4460 has these fields:
- [20:19] CAMERARX_CSI22_CAMMODE
- [17:16] CAMERARX_CSI21_CAMMODE

Both of them used to configure each CSIPHY module, to use it on:
- 0x0: D-PHY mode (for CSI-2 cameras)
- 0x1: Data/Strobe mode (for CCP2 mode)
- 0x2: Data/Clock mode (for either CCP2 or CSI1 mode)
- 0x3: Reserved(4430), or GPI/Parallel (4460/3630) mode

But other OMAP4 bitfields are completely unexisting on OMAP3 (3630),
as there some slight IP changes on the way the Camera CSIPHY is
controlled.

Regards,
Sergio

>
> I think the solution to conditionally access it in the ISP driver wou=
ld be,
> albeit not pretty, a workable one: the driver is unlikely to be used =
on
> other platforms and this is a single register accessed in a single lo=
cation.
> I'm of course open for better options.
>
> Cc Sergio.
>
> --
> Sakari Ailus
> e-mail: sakari.ailus@iki.fi =A0 =A0 jabber/XMPP/Gmail: sailus@retiisi=
=2Eorg.uk
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
