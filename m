From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Tue, 19 Oct 2010 08:46:27 -0700
Message-ID: <20101019154627.GC4589@kroah.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1287387875-14168-2-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 18, 2010 at 09:44:33AM +0200, Ohad Ben-Cohen wrote:
> +#else /* !CONFIG_OMAP_HWSPINLOCK */
> +
> +static inline struct omap_hwspinlock *omap_hwspinlock_request(void)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}

One note, do you really want to fail if this option isn't built into the
kernel, yet you have a driver that is asking for it?  Shouldn't you
instead just silently succeed, and let the code path get compiled away?

We did that for debugfs, after learning the pain that procfs had with
its api for "is not built".  Doing it the way you are requires the user
to always test for -ENOSYS, when in reality, if that is returned,
there's nothing the driver can do about it, so it should just not worry
about it.

Just something to think about.

thanks,

greg k-h
