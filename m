From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
 requested pads
Date: Tue, 8 Mar 2011 17:14:29 +0530
Message-ID: <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
 <87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52742 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab1CHLpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:45:09 -0500
In-Reply-To: <87tyfi49cs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

> On Sat, Mar 5, 2011 at 7:27 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
> [...]
>
>>> =A0/* Assumes the calling function takes care of locking */
>>> =A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>>> =A0{
>>> @@ -342,6 +365,9 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info =
*hmux, u8 state)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags &=3D ~OMAP_DEVICE_=
PAD_ENABLED;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val =3D pad->idle;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (flags & OMAP_DEVICE_PA=
D_WAKEUP)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val |=3D O=
MAP_WAKEUP_EN;
>>> +
>>
>> Is this needed on every idle transition?
>>
>> You're currently setting it on every idle transition, but never clea=
ring
>> it. =A0If it is to be a one-time thing, then move it to the early in=
it of
>> the mux.
>
> Just to clarify...
>
> So as soon as the hwmod is first idled, IO-ring wakeups are enabled f=
or
> any pads that have OMAP_DEVICE_PAD_WAKEUP.
>
> The problem here (compared with behavior of existing code) is that th=
ere
> is no provision for disabling IO-ring wakeups.
>
> For example, with current code, you can disable wakeups from userspac=
e
> using the sysfs control file /sys/devices/.../power/wakeup, whose val=
ue
> can be checked using device_may_wakeup(), like current
> mach-omap2/serial.c code does.
>
> With this patch, IO-ring wakeups are always enabled, and never disabl=
ed.

I am reworking on this patch with new patch this will not have below tw=
o snip
changes and will be removed.

+                       if (flags & OMAP_DEVICE_PAD_WAKEUP)
+                               val |=3D OMAP_WAKEUP_EN;
+

and

+                       val |=3D omap_mux_read(pad->partition,
+                                               pad->mux->reg_offset);

some more changes I have added for default rx serial pad as below
[this will be done in patch 6/7]

+       {
+               .name   =3D "uart1_rx.uart1_rx",
+               .flags  =3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAK=
EUP,
+               .enable =3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+               .idle   =3D OMAP_WAKEUP_EN,
+       },
+};


So with this change it will enable io-pad wakeup once we disable
clocks based on
=2Eidle values and remux back to .enable values once we enable clocks b=
ack.
so io-pad wakeup for rx will be enabled only when I do put_sync.
[I verified this with lauterbach also]

I am not sure whether now we can control read/writes to pad_mux from an=
y driver
interface and I think we have to go through mux framework for any
read/writes to mux.
with this I cant control pad wake up capabilities with sysfs as done
earlier in serial.c
now control to read/write to pad is outside scope of the driver
interface as omap_hwmod_mux
is the one that takes decision for driver with mux values provided
during omap_hwmod_mux_init.

--
Thanks,
Govindraj.R


>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
