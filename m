From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "mfd: tps65218: add version check to the PMIC probe" to
 the regulator tree
Date: Wed, 31 Aug 2016 15:50:18 +0100
Message-ID: <20160831145018.GO9415@dell>
References: <1466412218-5906-8-git-send-email-j-keerthy@ti.com>
 <E1bXZjd-0000YR-7n@debutante>
 <20160831083114.GP10121@dell>
 <20160831114105.GH3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160831114105.GH3950-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Aug 2016, Mark Brown wrote:

> On Wed, Aug 31, 2016 at 09:31:14AM +0100, Lee Jones wrote:
> > On Wed, 10 Aug 2016, Mark Brown wrote:
> 
> > > The patch
> 
> > >    mfd: tps65218: add version check to the PMIC probe
> 
> > Why did you take this patch?
> 
> You acked it, that's saying that you're OK with the patch and are
> expecting someone else to apply it.

No it doesn't, you made that up. :)

I know when you and some others Ack a patch, that's what you mean, but
you've been working with me for long enough to know that's not what I
mean when I Ack a patch.  I do it as an indication that I've reviewed
the patch and I'm happy with it.  Most MFD patches that have
dependencies tend to come through the MFD tree.  If that's not the
case, my Ack is usually backed up with a "I expect this patch to go
through the X tree".

> > I now have a merge conflict.
> 
> > Did you provide a pull-request that I can use to resolve?
> 
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

Thanks.

>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/tps65218-ver-check
> 
> for you to fetch changes up to f11fa1796a4b4f8c6d4ced37e8824276ec57057d:
> 
>   mfd: tps65218: add version check to the PMIC probe (2016-08-10 18:21:55 +0100)
> 
> ----------------------------------------------------------------
> mfd: tps65218: Add hardware version check
> 
> This will be used for quirks by some function drivers.
> 
> ----------------------------------------------------------------
> Tero Kristo (1):
>       mfd: tps65218: add version check to the PMIC probe
> 
>  drivers/mfd/tps65218.c       | 9 +++++++++
>  include/linux/mfd/tps65218.h | 1 +
>  2 files changed, 10 insertions(+)



-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
