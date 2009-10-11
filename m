From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v1 2/2] OMAP3: add platform devices for ETM and ETB
Date: Mon, 12 Oct 2009 00:10:43 +0200
Message-ID: <63386a3d0910111510q2e17fec7ofe3db29a4d1f7822@mail.gmail.com>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
	<1255279286-8904-2-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255279286-8904-2-git-send-email-virtuoso@slind.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

2009/10/11 Alexander Shishkin <virtuoso@slind.org>:

> This enables debug components found in omap3xxx.
> (...)
> +static struct resource rx51_etb_resource =3D {
> + =A0 =A0 =A0 .start =3D ETB_BASE,
> + =A0 =A0 =A0 .end =A0 =3D ETB_BASE + SZ_4K,

.end =3D ETB_BASE + SZ_4K - 1

This will play with the resource paradigm and resource_size() will
work correctly in the driver after this.

> + =A0 =A0 =A0 .flags =3D IORESOURCE_MEM,
> +};
> +
>(...)
> +
> +static struct resource rx51_etm_resource =3D {
> + =A0 =A0 =A0 .start =3D ETM_BASE,
> + =A0 =A0 =A0 .end =A0 =3D ETM_BASE + SZ_4K,

Ditto.

> + =A0 =A0 =A0 .flags =3D IORESOURCE_MEM,
> +};

Linus Walleij
