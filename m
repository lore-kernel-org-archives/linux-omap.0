From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [RFC 2/5] OMAP: mux: Make low level function private
Date: Sat, 25 Sep 2010 04:39:16 +0530
Message-ID: <AANLkTikN8M+6Q0cDdp29mnQdtqSwL4Zp5Kpoz8TL+WHu@mail.gmail.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <1285319748-28976-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:57191 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755424Ab0IXXQb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 19:16:31 -0400
Received: by mail-wy0-f170.google.com with SMTP id 20so4062015wye.15
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 16:16:30 -0700 (PDT)
In-Reply-To: <1285319748-28976-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Sep 24, 2010 at 2:45 PM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> omap_mux_read / omap_mux_write should not be accessed directly
> outside the mux framework.
> Do we really have use case that require dynamic mux change beside
> GPIO?
>

Only case I can think of is for any workarounds for issues that turn up=
=2E
No such cases exist today on OMAP3 at least, and none are likely to
appear in future (I hope). So your assumption is valid.

- Anand

> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> =A0arch/arm/mach-omap2/mux.c | =A0 =A04 ++--
> =A0arch/arm/mach-omap2/mux.h | =A0 18 ------------------
> =A02 files changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 83e7686..8285cb8 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -55,7 +55,7 @@ static u8 omap_mux_flags;
> =A0static struct mux_partition mux_partitions[MAX_PARTITIONS_NR];
> =A0static u32 mux_partitions_cnt;
>
> -u16 omap_mux_read(u16 reg, u8 id)
> +static u16 omap_mux_read(u16 reg, u8 id)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *mux_base =3D mux_partitions[id].base;
>
> @@ -65,7 +65,7 @@ u16 omap_mux_read(u16 reg, u8 id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return __raw_readw(mux_base + reg);
> =A0}
>
> -void omap_mux_write(u16 val, u16 reg, u8 id)
> +static void omap_mux_write(u16 val, u16 reg, u8 id)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *mux_base =3D mux_partitions[id].base;
>
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index 9b28576..da67501 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -173,24 +173,6 @@ u16 omap_mux_get_gpio(int gpio);
> =A0void omap_mux_set_gpio(u16 val, int gpio);
>
> =A0/**
> - * omap_mux_read() - read mux register
> - * @mux_offset: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Offset of the mux reg=
ister
> - * @id: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0identifier of=
 the control module partition
> - *
> - */
> -u16 omap_mux_read(u16 mux_offset, u8 id);
> -
> -/**
> - * omap_mux_write() - write mux register
> - * @val: =A0 =A0 =A0 =A0 =A0 =A0 =A0 New mux register value
> - * @mux_offset: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Offset of the mux reg=
ister
> - * @id: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0identifier of=
 the control module partition
> - *
> - * This should be only needed for dynamic remuxing of non-gpio signa=
ls.
> - */
> -void omap_mux_write(u16 val, u16 mux_offset, u8 id);
> -
> -/**
> =A0* omap_mux_write_array() - write an array of mux registers
> =A0* @board_mux: =A0 =A0 =A0 =A0 Array of mux registers terminated by=
 MAP_MUX_TERMINATOR
> =A0*
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
