From: Suman Anna <s-anna@ti.com>
Subject: Re: [RFC PATCH 1/3] of/device: manage resources similar to platform_device_add
Date: Tue, 13 Jan 2015 15:25:49 -0600
Message-ID: <54B58D5D.5070508@ti.com>
References: <1420651854-17768-1-git-send-email-s-anna@ti.com> <1420651854-17768-2-git-send-email-s-anna@ti.com> <CAL_Jsq+79cnCiww6g8ejki0yT59-N8eucHC3QGMbsXG4DksWuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+79cnCiww6g8ejki0yT59-N8eucHC3QGMbsXG4DksWuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pawel Moll <pawel.moll@arm.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Felipe Balbi <balbi@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 01/13/2015 02:38 PM, Rob Herring wrote:
> On Wed, Jan 7, 2015 at 11:30 AM, Suman Anna <s-anna@ti.com> wrote:
>> Drivers can use of_platform_populate() to create platform devices
>> for children of the device main node, and a complementary API
>> of_platform_depopulate() is provided to delete these child platform
>> devices. The of_platform_depopulate() leverages the platform API
>> for performing the cleanup of these devices.
>>
>> The platform device resources are managed differently between
>> of_device_add and platform_device_add, and this asymmetry causes
>> a kernel oops in platform_device_del during removal of the resources.
>> Manage the platform device resources similar to platform_device_add
>> to fix this kernel oops.
> 
> This is a known issue and has been attempted to be fixed before (I
> believe there is a revert in mainline). The problem is there are known
> devicetrees which have overlapping resources and they will break with
> your change.

Are you referring to 02bbde7849e6 (Revert "of: use
platform_device_add")? That one seems to be in registration path, and
this crash is in the unregistration path. If so, to fix the crash,
should we be skipping the release_resource() for now in
platform_device_del for DT nodes, or replace platform_device_unregister
with of_device_unregister in of_platform_device_destroy()?

This is a common crash and we cannot use of_platform_depopulate() today
in drivers to complement of_platform_populate().

Also, the platform_data crash is independent of this, I could reproduce
that one even with using of_device_unregister in a loop in driver remove.

regards
Suman

> 
> Rob
> 
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/of/device.c | 38 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 46d6c75c1404..fa27c1c71f29 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -50,6 +50,8 @@ EXPORT_SYMBOL(of_dev_put);
>>
>>  int of_device_add(struct platform_device *ofdev)
>>  {
>> +       int i, ret;
>> +
>>         BUG_ON(ofdev->dev.of_node == NULL);
>>
>>         /* name and id have to be set so that the platform bus doesn't get
>> @@ -63,7 +65,41 @@ int of_device_add(struct platform_device *ofdev)
>>         if (!ofdev->dev.parent)
>>                 set_dev_node(&ofdev->dev, of_node_to_nid(ofdev->dev.of_node));
>>
>> -       return device_add(&ofdev->dev);
>> +       for (i = 0; i < ofdev->num_resources; i++) {
>> +               struct resource *p, *r = &ofdev->resource[i];
>> +
>> +               if (!r->name)
>> +                       r->name = dev_name(&ofdev->dev);
>> +
>> +               p = r->parent;
>> +               if (!p) {
>> +                       if (resource_type(r) == IORESOURCE_MEM)
>> +                               p = &iomem_resource;
>> +                       else if (resource_type(r) == IORESOURCE_IO)
>> +                               p = &ioport_resource;
>> +               }
>> +
>> +               if (p && insert_resource(p, r)) {
>> +                       dev_err(&ofdev->dev, "failed to claim resource %d\n",
>> +                               i);
>> +                       ret = -EBUSY;
>> +                       goto failed;
>> +               }
>> +       }
>> +
>> +       ret = device_add(&ofdev->dev);
>> +       if (ret == 0)
>> +               return ret;
>> +
>> +failed:
>> +       while (--i >= 0) {
>> +               struct resource *r = &ofdev->resource[i];
>> +               unsigned long type = resource_type(r);
>> +
>> +               if (type == IORESOURCE_MEM || type == IORESOURCE_IO)
>> +                       release_resource(r);
>> +       }
>> +       return ret;
>>  }
>>
>>  int of_device_register(struct platform_device *pdev)
>> --
>> 2.2.1
>>
