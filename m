From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] of/device: manage resources similar to platform_device_add
Date: Tue, 13 Jan 2015 14:38:18 -0600
Message-ID: <CAL_Jsq+79cnCiww6g8ejki0yT59-N8eucHC3QGMbsXG4DksWuQ@mail.gmail.com>
References: <1420651854-17768-1-git-send-email-s-anna@ti.com> <1420651854-17768-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420651854-17768-2-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 7, 2015 at 11:30 AM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> Drivers can use of_platform_populate() to create platform devices
> for children of the device main node, and a complementary API
> of_platform_depopulate() is provided to delete these child platform
> devices. The of_platform_depopulate() leverages the platform API
> for performing the cleanup of these devices.
>
> The platform device resources are managed differently between
> of_device_add and platform_device_add, and this asymmetry causes
> a kernel oops in platform_device_del during removal of the resources.
> Manage the platform device resources similar to platform_device_add
> to fix this kernel oops.

This is a known issue and has been attempted to be fixed before (I
believe there is a revert in mainline). The problem is there are known
devicetrees which have overlapping resources and they will break with
your change.

Rob

>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/of/device.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 46d6c75c1404..fa27c1c71f29 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -50,6 +50,8 @@ EXPORT_SYMBOL(of_dev_put);
>
>  int of_device_add(struct platform_device *ofdev)
>  {
> +       int i, ret;
> +
>         BUG_ON(ofdev->dev.of_node == NULL);
>
>         /* name and id have to be set so that the platform bus doesn't get
> @@ -63,7 +65,41 @@ int of_device_add(struct platform_device *ofdev)
>         if (!ofdev->dev.parent)
>                 set_dev_node(&ofdev->dev, of_node_to_nid(ofdev->dev.of_node));
>
> -       return device_add(&ofdev->dev);
> +       for (i = 0; i < ofdev->num_resources; i++) {
> +               struct resource *p, *r = &ofdev->resource[i];
> +
> +               if (!r->name)
> +                       r->name = dev_name(&ofdev->dev);
> +
> +               p = r->parent;
> +               if (!p) {
> +                       if (resource_type(r) == IORESOURCE_MEM)
> +                               p = &iomem_resource;
> +                       else if (resource_type(r) == IORESOURCE_IO)
> +                               p = &ioport_resource;
> +               }
> +
> +               if (p && insert_resource(p, r)) {
> +                       dev_err(&ofdev->dev, "failed to claim resource %d\n",
> +                               i);
> +                       ret = -EBUSY;
> +                       goto failed;
> +               }
> +       }
> +
> +       ret = device_add(&ofdev->dev);
> +       if (ret == 0)
> +               return ret;
> +
> +failed:
> +       while (--i >= 0) {
> +               struct resource *r = &ofdev->resource[i];
> +               unsigned long type = resource_type(r);
> +
> +               if (type == IORESOURCE_MEM || type == IORESOURCE_IO)
> +                       release_resource(r);
> +       }
> +       return ret;
>  }
>
>  int of_device_register(struct platform_device *pdev)
> --
> 2.2.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
