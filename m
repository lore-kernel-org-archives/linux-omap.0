From: Jorge Bustamante <jbustamante.init@gmail.com>
Subject: Re: Requirement for DSI video mode support
Date: Wed, 13 Oct 2010 14:54:33 -0500
Message-ID: <AANLkTim_y5SgtkwdCHVT4xMsmyxhs9NE3pBiXEtMe1nX@mail.gmail.com>
References: <AANLkTikBn63Y1CofZksexds7tBqzxrNvX3MD=tZ49hDw@mail.gmail.com>
	<1286532774.28499.1088.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37583 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0JMTzR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Oct 2010 15:55:17 -0400
Received: by gyg13 with SMTP id 13so347157gyg.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Oct 2010 12:54:57 -0700 (PDT)
In-Reply-To: <1286532774.28499.1088.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "m-iovescu1@ti.com" <m-iovescu1@ti.com>, "nm@ti.com" <nm@ti.com>, "archit@ti.com" <archit@ti.com>, "y-qassid@ti.com" <y-qassid@ti.com>, "a-aguirre@ti.com" <a-aguirre@ti.com>

On Fri, Oct 8, 2010 at 5:12 AM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Hi,
>
> On Mon, 2010-09-20 at 22:18 +0200, ext Jorge Bustamante wrote:
>> Hi,
>>
>> We (TI) have been working on a DSI video mode driver for OMAP4 and I
>
> I hope it's also for OMAP3?
>

I am not aware of any videomode display using OMAP3... so it would be
hard to test it with OMAP3, but I think we can make sure that it
doesn't break existing command mode drivers there at least.

>> am aware that other people are working with similar drivers. We had =
to
>> tweak the code to make the drivers work with current code but we wou=
ld
>> like to make it the correct way, that is, introducing a proper
>> functionality instead of inserting tweaks in the present command mod=
e
>> driver. Therefore, there is an initiative from us to modify current
>> dss/dsi code to support DSI video mode.
>>
>> We have collected a list of requirements and ideas (with the help of
>> ppl copied) from our experience working with these drivers, but it
>> would be great if you can discuss/comment further on this.
>>
>> Requirements:
>>
>> - A better way of exposing VC's to a panel driver, since most panels
>> use more than one VC. Currently the design supports only one per
>> panel. Perhaps a VC resource pool could be created.
>
> Hmm, why would most panels use more than one VC? I haven't seen a sin=
gle
> one =3D).
>
> Nevertheless, it should be possible to use multiple VCs in one driver=
=2E
> I've implemented a driver for a buffer chip that used all 4 channels.
> But it's true that there's no allocation of the VCs, so if you have t=
wo
> panels at the same time, there's no proper way to make sure they don'=
t
> use overlapping VCs.
>

You are right, my sentence was wrong regarding VCs, most of them -if
not all- require just one VC, but it is still handy as you mention to
be able to use more than one; for instance, using one for sending
commands (LP mode) and one for video data (HS mode), both pointing to
same VC ID of course. Since VCs are not tied to a particular VC ID, I
think we can manage them as mere resources and implementing some kind
of pool sounds good to me in order to avoid overlapping VCs as you
mention.

>> - A way of imposing restrictions on clock sources based on dsi mode.
>> - Runtime calculation of required clocks and PLL parameters. This is
>> to reduce complexity in clock calculations, specially when having tw=
o
>> panels running at the same time.
>> - A way to pass specific requirements from panel driver to DSI drive=
r
>> (enable/disable BTA, set HS Clk always on, etc).
>> - Remove some hardcoded values in dsi.c and make the panel pass the
>> information to DSI driver(RX, TX fifo sizes of VCs, enabling/disabli=
ng
>> dsi timers, etc)
>> - A cleaner way of handling both DSI1 and DSI2 blocks(and more in
>> omap5) in the same driver.
>> - A way to easily set non-burst event mode, non-burst pulse mode and
>> burst mode configuration as defined on DSI protocol specs.
>> - A way to calculate correct DSI blanking parameters based on panel
>> blanking requirements (for DSI Video panels, these will be have to b=
e
>> specified statically somewhere, much like DPI displays).
>> - Remove timeout error/warnings when disabling dsi phy interface sin=
ce
>> on video mode it should wait instead for next vsync.
>
> These are sound good to me.
>
>> Design ideas:
>>
>> - It could actually be worthwhile to have separate files for command
>> and video mode and a core dsi driver file.
>
> I think that's a good choice. At some point I thought of separating D=
SI
> PLL, CIO and core stuff to separate files, but I never had time. And =
it
> would also mean making lots of functions non-static.
>

=46rom my personal point of view, we could probably manage to make it
work on same file and test it for a while first and just then try to
do it on separate files to avoid making a lot of changes at once. This
is having in mind that most of the proposed points are actually
additions that apply to DSI command mode as well (BTA, HS clocks, VCs,
etc).

>> - We can have a enum like this to choose between modes:
>>
>> plat/display.h can have an enum like:
>> enum omap_dss_dsi_mode {
>> =A0 =A0 OMAP_DSS_DSI_CMDMODE =A0 =3D 1 << 0,
>> =A0 =A0 OMAP_DSS_DSI_VIDEOMODE =3D 1 << 1,
>>
>> };
>> Nit pick - either make it #define and have bit offset as above OR
>> Better still, you wont need both at the same time, so bit offset won=
t be
>> useful too much.. OMAP_DSS_DSI_CMDMODE =3D 1, OMAP_DSS_DSI_VIDEOMODE=
 =3D 2,
>>
>> - If we want a user to switch between modes, we may need to have a
>
> While I don't see any reason to forbid changing modes, I don't see an=
y
> real reason to implement switching between the modes either. If it co=
mes
> for free, sure, but if it means lots of implementation, I'd rather le=
ave
> it out. Or do you have some use cases where switching modes is
> important?
>
> =A0Tomi
>
>
>

Again, you are right, I believe that dynamically switching modes is
not that important now, and agree that there is not a real reason to
implement it... probably it wouldn't be that hard to include it but I
think the simpler the patch the better for now, right?

Regards,
Jorge Bustamante
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
