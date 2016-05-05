From: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mfd: lp873x: Add lp873x PMIC support
Date: Thu, 5 May 2016 14:05:48 +0530
Message-ID: <CAKDJKT7AmeBkwH9=JpK49ADrogDqF1XCyHmZFiv4Ouwn-k9Y6g@mail.gmail.com>
References: <1462425040-18566-1-git-send-email-j-keerthy@ti.com>
	<1462425040-18566-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462425040-18566-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Keerthy,

> + * struct tps65086 - state holder for the tps65086 driver

need to change name over here in comment.

> + * Device data may be used to access the LP873X chip
> + */
> +struct lp873x {
> +       struct device *dev;
> +       unsigned long id;
> +       u8 rev;
> +       struct mutex lp873_lock;        /* lock guarding the data structure */
> +       struct regmap *regmap;
> +};
> +#endif /*  __LINUX_MFD_LP873X_H */
> --

Regards
Manish Badarkhe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
