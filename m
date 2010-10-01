From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] omap: zoom2: fix build break when CONFIG_WL12XX_PLATFORM_DATA=n
Date: Fri, 1 Oct 2010 23:21:27 +0200
Message-ID: <AANLkTi=+dtqdZLb8rfu8NZRU5GceUL5+S3B=MeW1xF=M@mail.gmail.com>
References: <1285965236-17907-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285965236-17907-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 1, 2010 at 10:33 PM, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
> Fix this build break when CONFIG_WL12XX_PLATFORM_DATA is not set.

A similar fix was already submitted and is pending to be merged
(http://permalink.gmane.org/gmane.linux.kernel.wireless.general/56595)

> There are still many warnings about the function wl12xx_set_platform_=
data
> being unused. Haven't fixed those. Ohad, care to take a look?

Sure. Which warnings do you refer to (I haven't seen any) ?

Thanks,
Ohad.

>
> =A0include/linux/wl12xx.h | =A0 =A07 +++++++
> =A01 file changed, 7 insertions(+)
>
> Index: linux-2.6/include/linux/wl12xx.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/wl12xx.h
> +++ linux-2.6/include/linux/wl12xx.h
> @@ -32,7 +32,14 @@ struct wl12xx_platform_data {
> =A0 =A0 =A0 =A0int board_ref_clock;
> =A0};
>
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA
> =A0int wl12xx_set_platform_data(const struct wl12xx_platform_data *da=
ta);
> +#else
> +static int wl12xx_set_platform_data(const struct wl12xx_platform_dat=
a *data)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> =A0const struct wl12xx_platform_data *wl12xx_get_platform_data(void);
>
> =A0#endif
>
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
