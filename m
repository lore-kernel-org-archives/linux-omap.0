From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/4] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Thu, 3 Dec 2015 17:42:31 +0200
Message-ID: <566062E7.2020705@ti.com>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com>
 <1449153192-9082-4-git-send-email-peter.ujfalusi@ti.com>
 <6922343.04ZpTXZq7O@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6922343.04ZpTXZq7O@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 12/03/2015 05:32 PM, Arnd Bergmann wrote:
> On Thursday 03 December 2015 16:33:11 Peter Ujfalusi wrote:
>> +
>> +/**
>> + * dma_request_chan - try to allocate an exclusive slave channel
>> + * @dev:       pointer to client device structure
>> + * @name:      slave channel name
>> + *
>> + * Returns pointer to appropriate DMA channel on success or an erro=
r pointer.
>> + */
>> +struct dma_chan *dma_request_chan(struct device *dev, const char *n=
ame)
>> +{
>> +       struct dma_device *d, *_d;
>> +       struct dma_chan *chan =3D NULL;
>> +
>> +       /* If device-tree is present get slave info from here */
>> +       if (dev->of_node)
>> +               chan =3D of_dma_request_slave_channel(dev->of_node, =
name);
>> +
>> +       /* If device was enumerated by ACPI get slave info from here=
 */
>> +       if (has_acpi_companion(dev) && !chan)
>> +               chan =3D acpi_dma_request_slave_chan_by_name(dev, na=
me);
>=20
> I just noticed that you are creating this as a new interface, rather =
than
> changing dma_request_slave_channel_reason() and making the old interf=
ace
> a static inline wrapper. What is the reasoning behind that?

Oh, it was in my plans. Will do it for v02

> I think if we make both interfaces do the same thing, it's easier
> to do the migration.
>=20
>> +       if (chan) {
>> +               /* Valid channel found */
>> +               if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DE=
=46ER)
>> +                       return chan;
>> +
>> +               pr_warn("%s: %s DMA request failed, falling back to =
legacy\n",
>> +                       __func__, dev->of_node ? "OF" : "ACPI");
>> +       }
>=20
> Maybe print the error code as well?

Or remove the print altogether?
In a healthy system we will either get the channel or the EPROBE_DEFER,=
 in
case of the platforms where the DT lookup does not work we expect error=
s and
it is 'normal'.
I think if we fail via DT/ACPI and we fail with legacy also then the cl=
ient
driver will say something about it anyways, or deal with it as it see f=
its.

--=20
P=E9ter
