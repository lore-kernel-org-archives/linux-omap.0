From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Tue, 19 Oct 2010 22:18:57 +0200
Message-ID: <AANLkTi=TPNuDeEwqZzpSaz71rjghjg=6V0stFFcmpB+O@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-2-git-send-email-ohad@wizery.com> <20101019154627.GC4589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101019154627.GC4589@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 5:46 PM, Greg KH <greg@kroah.com> wrote:
> On Mon, Oct 18, 2010 at 09:44:33AM +0200, Ohad Ben-Cohen wrote:
>> +#else /* !CONFIG_OMAP_HWSPINLOCK */
>> +
>> +static inline struct omap_hwspinlock *omap_hwspinlock_request(void)
>> +{
>> + =A0 =A0 return ERR_PTR(-ENOSYS);
>> +}
>
> One note, do you really want to fail if this option isn't built into =
the
> kernel, yet you have a driver that is asking for it? =A0Shouldn't you
> instead just silently succeed, and let the code path get compiled awa=
y?
>
> We did that for debugfs, after learning the pain that procfs had with
> its api for "is not built". =A0Doing it the way you are requires the =
user
> to always test for -ENOSYS, when in reality, if that is returned,
> there's nothing the driver can do about it, so it should just not wor=
ry
> about it.
>
> Just something to think about.

Completely agree; if hwspinlock support is not needed, we better let
its users run uninterruptedly. I'll change it.

Thanks,
Ohad.

>
> thanks,
>
> greg k-h
>
