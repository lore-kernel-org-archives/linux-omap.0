From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: hwmod: Add a new state to handle hwmods
 left enabled at init
Date: Mon, 21 Nov 2011 15:33:13 +0530
Message-ID: <CAAL8m4xY=dRKuY697zdWaqUowyHecfC7cLRiPYNjdaCd4oau-A@mail.gmail.com>
References: <1321856114-11260-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39190 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab1KUKDf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Nov 2011 05:03:35 -0500
Received: by fagn18 with SMTP id n18so5715709fag.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Nov 2011 02:03:34 -0800 (PST)
In-Reply-To: <1321856114-11260-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com

Hi Rajendra,

On Mon, Nov 21, 2011 at 11:45 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
> enabled state by the hwmod framework post the initial setup.
> Once a real user of the device (a driver) tries to enable it
> at a later point, the hwmod framework throws a WARN() about
> the device being already in enabled state.
>
> Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
> to identify such devices/hwmods, so nothing but just a state
> change to '_HWMOD_STATE_ENABLED' can be done when the device/hwmod
> is requested to be enabled (the first time) by its driver/user.
>
> A good example of a such a device is an UART used as debug console.
> The UART module needs to be kept enabled through the boot, until the
> UART driver takes control of it, for debug prints to appear on
> the console.
>
> Acked-by: Kevin Hilman <khilman@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> changes in v2:
> Fixed minor typos, removed stay change, updated comment
> in header.
>
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 15 =
++++++++++++++-
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A06 ++++++
> =A02 files changed, 20 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 6b3088d..72ee723 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1441,6 +1441,17 @@ static int _enable(struct omap_hwmod *oh)
>
> =A0 =A0 =A0 =A0pr_debug("omap_hwmod: %s: enabling\n", oh->name);
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* hwmods' with HWMOD_INIT_NO_IDLE flag set, are left
> + =A0 =A0 =A0 =A0* in enabled state at init.
> + =A0 =A0 =A0 =A0* Now that someone is really trying to enable them,
> + =A0 =A0 =A0 =A0* just update the state.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (oh->_state =3D=3D _HWMOD_STATE_ENABLED_AT_INIT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->_state =3D _HWMOD_STATE_ENABLED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +

one issue returning from here without doing
omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);

causes hmux->enabled to be false after first _enable (get_sync)

and for first _idle(put/put_sync)

omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
will not happen and will not enable rx_pad wake-up for uart.
so this is causing wake-up failures from off mode.

[code_snip]

void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
{
        int i;

         /* Runtime idling of dynamic pads */
        if (state =3D=3D _HWMOD_STATE_IDLE && hmux->enabled) {
                for (i =3D 0; i < hmux->nr_pads_dynamic; i++) {
                        struct omap_device_pad *pad =3D hmux->pads_dyna=
mic[i];
                        int val =3D -EINVAL;

                        val =3D pad->idle;
                        omap_mux_write(pad->partition, val,
                                        pad->mux->reg_offset);
                }

                return;
        }

       [..]

      if (state =3D=3D _HWMOD_STATE_ENABLED)
                hmux->enabled =3D true;
      else
                hmux->enabled =3D false;
}

[..]

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
