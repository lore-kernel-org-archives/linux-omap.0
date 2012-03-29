From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH v2 1/5] spi/omap: Remove bus_num usage for instance index
Date: Thu, 29 Mar 2012 14:01:52 +0530
Message-ID: <CAM=Q2csDWfV5wy1LNX2=JP38t7FAtrGxxq9D7v-wX81j0paLSg@mail.gmail.com>
References: <1332769480-28069-1-git-send-email-shubhrajyoti@ti.com>
	<1332769480-28069-2-git-send-email-shubhrajyoti@ti.com>
	<CAC83ZvKXMGfbM=ay_cPim1_PQk5nDRuC3+csOVfLzOVr9Qg6rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39647 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab2C2Ibx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 04:31:53 -0400
In-Reply-To: <CAC83ZvKXMGfbM=ay_cPim1_PQk5nDRuC3+csOVfLzOVr9Qg6rg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Tarun,

On Wed, Mar 28, 2012 at 2:15 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Mon, Mar 26, 2012 at 7:14 PM, Shubhrajyoti D <shubhrajyoti@ti.com>=
 wrote:
>> From: Benoit Cousson <b-cousson@ti.com>
>>
>> bus_num was used to reference the mcspi controller instance in a fix=
ed array.
>> Remove this array and store this information directly inside drvdata=
 structure.
>>
>> bus_num is now just set if the pdev->id is present or with -1 for dy=
namic
>> allocation by SPI core, but the driver does not access it anymore.
>>
>> Clean some bad comments format, and remove un-needed space.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> [Cleanup the OMAP2_MCSPI_MAX_CTRL macro as it is not needed anymore]
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> =A0drivers/spi/spi-omap2-mcspi.c | =A0 75 ++++++++++++++++++--------=
--------------
>> =A01 files changed, 34 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-m=
cspi.c
>> index bb9274c..7785091 100644
>> --- a/drivers/spi/spi-omap2-mcspi.c
>> +++ b/drivers/spi/spi-omap2-mcspi.c
>> @@ -45,9 +45,6 @@
>>
<snip>
>>
>> =A0 =A0 =A0 =A0tmp =3D OMAP2_MCSPI_WAKEUPENABLE_WKEN;
>> =A0 =A0 =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp=
);
>> - =A0 =A0 =A0 omap2_mcspi_ctx[master->bus_num - 1].wakeupenable =3D =
tmp;
>> + =A0 =A0 =A0 ctx->wakeupenable =3D tmp;
> Can't we get rid of tmp now? For example:
> ctx->wakeupenable =3D OMAP2_MCSPI_WAKEUPENABLE_WKEN;
> mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, ctx->wakeupenable);

Yes the tmp variable could be optimized
since it is in addition to the $SUBJECT will do it in a separate patch =
=2E
Is that fine?

> --
> Tarun
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
