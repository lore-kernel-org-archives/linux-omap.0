From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/5] Input: Add tps65217 power button driver
Date: Mon, 20 Jun 2016 08:06:04 -0500
Message-ID: <20160620130604.GA23272@rob-hp-laptop>
References: <20160616114110.23455-1-m.niestroj@grinn-global.com>
 <20160616114110.23455-6-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160616114110.23455-6-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 16, 2016 at 01:41:10PM +0200, Marcin Niestroj wrote:
> This driver enables us to use tps65217's power button as KEY_POWER on
> am335x boards (directly connected button in chiliboard, accessible pin
> via expansion header in beaglebone). This patch has been tested with
> chiliboard.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
> ---
> depends on patches 1-4 in series
> 
>  .../bindings/input/tps65217-pwrbutton.txt          |  17 +++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/input/misc/Kconfig                         |  10 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/tps65217-pwrbutton.c            | 131 +++++++++++++++++++++
>  4 files changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
>  create mode 100644 drivers/input/misc/tps65217-pwrbutton.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
