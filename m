From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Wed, 4 Aug 2010 16:55:27 -0600
Message-ID: <AANLkTi=CRCKO3Vjsm3K+OZO1Ea=oGcZovEzfw71r=gtM@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50044 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab0HDWzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 18:55:47 -0400
Received: by ywh1 with SMTP id 1so2187414ywh.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Aug 2010 15:55:47 -0700 (PDT)
In-Reply-To: <1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 24, 2010 at 5:43 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Implement the new runtime PM framework as a thin layer on top of the
> omap_device API. =A0Since we don't have an OMAP-specific bus, overrid=
e
> the runtime PM hooks for the platform_bus for the OMAP specific
> implementation.
[...]
> +int platform_pm_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> + =A0 =A0 =A0 struct omap_device *odev =3D to_omap_device(pdev);
> + =A0 =A0 =A0 int r, ret =3D 0;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 if (dev->driver->pm && dev->driver->pm->runtime_suspend=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_suspen=
d(dev);
> + =A0 =A0 =A0 if (!ret && omap_device_is_valid(odev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_device_idle(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(r);

=46or the record, I should note here that this is *really* dangerous.
When handed a random platform_device pointer, it is not safe to use
to_omap_device() and dereference it with omap_device_is_valid().
There are no guarantees that the dereference is actually valid,
particularly so when the platform_device has been dynamically
allocated.

It is only okay to use to_omap_device() when the code is already
absolutely sure that the platform_device is in fact contained by a
struct omap_device.  There needs to be a different method to test if
it is contained by an omap_device before doing the dereference.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
