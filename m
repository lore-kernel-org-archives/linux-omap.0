From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 2/4] drivers: hwspinlock: add OMAP implementation
Date: Wed, 24 Nov 2010 12:33:14 +0200
Message-ID: <AANLkTinqZ7sMK3kOVV-7UBwx2q9qPoVr3zbze9Qp+0cm@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-3-git-send-email-ohad@wizery.com> <1290554607.3647.12.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290554607.3647.12.camel@atlantis.mindbit.ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 24, 2010 at 1:23 AM, Ionut Nicu <ionut.nicu@mindbit.ro> wro=
te:
> At iounmap_base you unmap state->io_base, but that's set only after t=
his
> check. You should probably iounmap(io_base).

Of course. Thanks.


>
> Regards,
> Ionut.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
