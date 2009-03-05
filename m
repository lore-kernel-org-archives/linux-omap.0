From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH 3/5] OV3640: Add driver
Date: Wed, 4 Mar 2009 17:42:18 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0903041737110.24268@shell2.speakeasy.net>
References: <A24693684029E5489D1D202277BE89442E1D9222@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE89442E1D9222@dlee02.ent.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 3 Mar 2009, Aguirre Rodriguez, Sergio Alberto wrote:
> +       {
> +               /* Note:  V4L2 defines RGB565 as:
> +                *
> +                *      Byte 0                    Byte 1
> +                *      g2 g1 g0 r4 r3 r2 r1 r0   b4 b3 b2 b1 b0 g5 g4 g3
> +                *
> +                * We interpret RGB565 as:
> +                *
> +                *      Byte 0                    Byte 1
> +                *      g2 g1 g0 b4 b3 b2 b1 b0   r4 r3 r2 r1 r0 g5 g4 g3

The V4L2 spec was corrected to define the RGB565 the normal way.
