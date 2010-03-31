From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: [PATCH-V2] OMAP: Fix for bus width which improves SD card's
	peformance.
Date: Wed, 31 Mar 2010 11:37:47 +0530
Message-ID: <x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com>
References: <35697.192.168.10.89.1265898023.squirrel@dbdmail.itg.ti.com>
	 <004701caab40$68b576e0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <004701caab40$68b576e0$544ff780@am.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: tony@atomide.com, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.lavinen@nokia.com
List-Id: linux-omap@vger.kernel.org

This patch improves low speeds for SD cards.
OMAP-MMC controller's can support maximum bus width of '8'.
when bus width is mentioned as "8" in controller data,the SD
stack will check whether bus width is "4" and if not it will
set bus width to "1" and there by degrading performance.
This patch fixes the issue and improves the performance of
SD cards.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>

---
In V2 : Appended Signed-off by Venkat and Ack by Madhu

 Here are my experiment numbers, on a Class 6 SDHC card:
 Read peformance is increased by 220%
 Write Performance is increased by 52%

 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index 83f0aff..8c97c22 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2092,7 +2092,7 @@ static int __init omap_hsmmc_probe(struct
                   MMC_CAP_WAIT_WHILE_BUSY;

      if (mmc_slot(host).wires >=3D 8)
-               mmc->caps |=3D MMC_CAP_8_BIT_DATA;
+               mmc->caps |=3D (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA=
);
      else if (mmc_slot(host).wires >=3D 4)
              mmc->caps |=3D MMC_CAP_4_BIT_DATA;

--
1.6.3.3


On Thu, Feb 11, 2010 at 11:04 PM, Madhusudhan <madhu.cr@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: kishore kadiyala [mailto:kishore.kadiyala@ti.com]
>> Sent: Thursday, February 11, 2010 8:20 AM
>> To: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: jarkko.lavinen@nokia.com; madhu.cr@ti.com
>> Subject: [PATCH] OMAP: Fix for bus width which improves SD card's
>> peformance.
>>
>> This patch improves low speeds for SD cards.
>> OMAP-MMC controller's can support maximum bus width of '8'.
>> when bus width is mentioned as "8" in controller data,the SD
>> stack will check whether bus width is "4" and if not it will
>> set bus width to "1" and there by degrading peformance.
>> This patch fixes the issue and improves the performance of
>> SD cards.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>
> ACK
>
> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
>
>> ---
>> =A0Here are my experiment numbers, on a Class 6 SDHC card:
>> =A0Read peformance is increased by 220%
>> =A0Write Performance is increased by 52%
>>
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 83f0aff..8c97c22 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2092,7 +2092,7 @@ static int __init omap_hsmmc_probe(struct
>> platform_device
>> *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY;
>>
>> =A0 =A0 =A0 if (mmc_slot(host).wires >=3D 8)
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_8_BIT_DATA | MMC_C=
AP_4_BIT_DATA);
>> =A0 =A0 =A0 else if (mmc_slot(host).wires >=3D 4)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>>
>> --
>> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
