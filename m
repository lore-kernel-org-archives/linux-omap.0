From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC 2/8] remoteproc: add omap implementation
Date: Wed, 22 Jun 2011 11:05:41 +0100
Message-ID: <BANLkTimAf9EqSX-yHh_0RPaeewndOyNUYA@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308640714-17961-3-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 21, 2011 at 8:18 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:

> +/* bootaddr isn't needed for the dual M3's */
> +static inline int omap_rproc_start(struct rproc *rproc, u64 bootaddr=
)

> +static inline int omap_rproc_stop(struct rproc *rproc)

These two functions don't need to be inline as far as I can see.

> +static struct rproc_ops omap_rproc_ops =3D {
> + =A0 =A0 =A0 .start =3D omap_rproc_start,
> + =A0 =A0 =A0 .stop =3D omap_rproc_stop,
> +};
