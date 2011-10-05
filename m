From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 1/5] ARM: dev_archdata: add private iommu extension
Date: Wed, 5 Oct 2011 11:26:32 +0200
Message-ID: <CAK=Wgba6xxD2DBJhM--AcTPBoNRiOZ_6f8+j3bfaCqZMO8A4+w@mail.gmail.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com> <1316948337-7924-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316948337-7924-2-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Cousson Benoit <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Sun, Sep 25, 2011 at 1:58 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Add a private iommu pointer to the ARM-specific arch data in the
> device struct, which will be used to attach iommu-specific data
> to devices which require iommu support.

Can you please take a look and ack/nack ?

With this change in hand, generic code will now be able to control
OMAP's iommu devices too, without having to use any OMAP-specific API
(this is demonstrated in this patch set).

This will allow us to further clean the existing mainline OMAP iommu
users, and focus on generic IOMMU code for future users
(rpmsg/remoteproc and Marek's upcoming generic DMA API).

The change is only effective when an iommu driver, which supports the
generic IOMMU API, is built (all of them must select
CONFIG_IOMMU_API), and otherwise is a nop.

Obviously the change itself is not OMAP-specific, and it will be
useful for other platforms too.

Thanks!
Ohad.

> Different iommu implementations (on different platforms) will attach
> different types of data to this pointer, so 'void *' is currently use=
d
> (the downside is reduced typesafety).
>
> Note: ia64, x86 and sparc have this exact iommu extension as well, an=
d
> if others are likely to adopt it too, we might want to consider
> adding this to the device struct itself directly.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0arch/arm/include/asm/device.h | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/dev=
ice.h
> index 9f390ce..6615f03 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -10,6 +10,9 @@ struct dev_archdata {
> =A0#ifdef CONFIG_DMABOUNCE
> =A0 =A0 =A0 =A0struct dmabounce_device_info *dmabounce;
> =A0#endif
> +#ifdef CONFIG_IOMMU_API
> + =A0 =A0 =A0 void *iommu; /* private IOMMU data */
> +#endif
> =A0};
>
> =A0struct pdev_archdata {
> --
> 1.7.4.1
>
>
