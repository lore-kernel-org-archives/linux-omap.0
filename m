From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable() conditions
Date: Fri, 15 Oct 2010 00:40:35 +0300
Message-ID: <AANLkTimRqaFkNkRzubY4-Gx=y0yJ_C1VFycL0+uEa_Wm@mail.gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
	<1284634286-8871-4-git-send-email-jason77.wang@gmail.com>
	<1284634286-8871-5-git-send-email-jason77.wang@gmail.com>
	<201009162339.06395.dmitry.torokhov@gmail.com>
	<4C9332CE.6040905@gmail.com>
	<20100917160709.GC14186@core.coreip.homeip.net>
	<4C9718E9.5040104@gmail.com>
	<4CB4314C.7050308@gmail.com>
	<20101012160055.GA6355@core.coreip.homeip.net>
	<4CB523B7.8010209@gmail.com>
	<AANLkTi=0b-q3LK3-4mgdpSP7pScVSF1ZWzD45bLoAmJO@mail.gmail.com>
	<4CB66777.5060309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4CB66777.5060309@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, vapier@gentoo.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, roman.tereshonkov@nokia.com
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 14, 2010 at 5:14 AM, Jason Wang <jason77.wang@gmail.com> wr=
ote:
> Grazvydas Ignotas wrote:
>> Working here on pandora too, applied on top of linux-next (did not
>> test suspend though).
>>
>> Not caused by this patch, but the old problem where lower measuremen=
t
>> bits get lost is back - when I draw diagonal line it looks like
>> stairs. I think it's caused by OMAP SPI driver, CCing linux-omap.
>>
>>
>
> Yes, it is OMAP spi driver issues, I have met the same problem before=
,
> please refer to:
> http://www.spinics.net/lists/arm-kernel/msg91538.html
>
> you can apply this patch and test again.

It solves my issue, thanks
Tested-by: Grazvydas Ignotas <notasas@gmail.com>

BTW I have done similar patch almost 2 years ago for exactly the same p=
roblem:
http://marc.info/?l=3Dlinux-omap&m=3D122565580616920&w=3D2
but then problem went away after random kernel update (from what I
remember), and my patch was no longer needed.


> From 393f445ab899abaf5d60a55a54f242c430507047 Mon Sep 17 00:00:00 200=
1
> From: Jason Wang <jason77.wang@gmail.com>
> Date: Thu, 14 Oct 2010 10:08:07 +0800
> Subject: [PATCH] spi/omap2_mcspi: disable channel after TX_ONLY trans=
fer in
> PIO mode
>
> In TX_ONLY transfer, the SPI controller can also receive data
> simultaneously and saves them in rx register. After the TX_ONLY
> transfer, the rx register will hold random data received during
> last tx transaction.
>
> If the next transfer is RX_ONLY, this random data has
> the possibility to affect this transfer like this:
>
> =A0If the spi controller is changed from TX_ONLY to RX_ONLY mode,
> =A0The random data makes the rx register full imediately and
> =A0triggers a dummy write (in SPI RX_ONLY transfer, we need a dummy
> =A0write to trigger the first transaction).
>
> =A0So the first data received in RX_ONLY transfer will be that
> =A0random data instead of something meaningfug.
>
> We can avoid this by a Disable/reenable toggle of the spi channel
> after the TX_ONLY transfer, since it purges the rx register.
>
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
> drivers/spi/omap2_mcspi.c | =A0 =A06 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index b3a94ca..43fab41 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -644,6 +644,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, str=
uct
> spi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (mcspi_wait_for_reg_bit(chstat_=
reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_MCS=
PI_CHSTAT_EOT) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "EOT t=
imed out\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable chan to purge rx datas recei=
ved in TX_ONLY
> transfer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* otherwise these rx datas will affe=
ct the direct following
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* RX_ONLY transfer.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 0);
> =A0 =A0 =A0 }
> out:
> =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> --
> 1.5.6.5
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
