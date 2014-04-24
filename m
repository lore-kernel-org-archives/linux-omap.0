From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RESEND 0/3] mfd: twl6040: Updates for i2s speed and fix for
 chip deadlock
Date: Thu, 24 Apr 2014 12:12:36 +0300
Message-ID: <5358D584.6080206@ti.com>
References: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

Lee,

On 04/01/2014 04:44 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> While looking into a report by Florian Vaussard [1] I have noticed co=
uple of most
> likely unrelated issues:
> - all boards using twl6040 configures the i2c bus to 400KHz while twl=
6040 is set
>   to 100KHz as default.
> - if I set the audpwron GPIO high [2] in the bootloader the i2c commu=
nication towards
>   twl6040 will be broken
> - got confirmation from HW design teams that twl6040 can work on a bu=
s with
>   400KHz even if after hard reset but it is optimal to swithc to 400K=
Hz mode as
>   soon as possible.
>=20
> The solution or these are:
> set the twl6040 to i2c fast mode with regmap patch
> Clear the INTID register right after we request the audpwron GPIO and=
 set it to
> low.

Do you want me to resend this series again?

Thanks,
P=E9ter

>=20
> Generated on top of:
> git://git.linaro.org/people/lee.jones/mfd.git for-mfd-next
>=20
> Tested on PandaBoard, PandaBoardES, OMAP4-blaze (SDP)
>=20
> [1] http://www.spinics.net/lists/arm-kernel/msg310725.html
> [2] Command in u-boot to enable the audpwron on PandaBoards: gpio set=
 127
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   mfd: twl6040: Select i2c fast mode as default with regmap patch
>   mfd: twl6040: Move register patching earlier in probe
>   mfd: twl6040: Clear the interrupt ID register before requesting IRQ
>=20
>  drivers/mfd/twl6040.c       | 19 +++++++++++++------
>  include/linux/mfd/twl6040.h |  1 +
>  2 files changed, 14 insertions(+), 6 deletions(-)
>=20
