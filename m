From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 6/9] ARM: OMAP1: move omap1_bl pdata out of arch/arm/*
Date: Thu, 30 Aug 2012 00:42:40 +0300
Message-ID: <503E8CD0.2090608@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
 <1346195937-6383-7-git-send-email-grinberg@compulab.co.il>
 <1346252664.12380.0.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1346252664.12380.0.camel@deskari>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/29/12 18:04, Tomi Valkeinen wrote:
> On Wed, 2012-08-29 at 02:18 +0300, Igor Grinberg wrote:
>> omap1 backlight platform data resides inside plat/board.h while it
>> should be inside include/linux/...
>> Move the omap1 backlight platform data to
>> include/linux/platform_data/.
>>
>> Cc: Richard Purdie <rpurdie@rpsys.net>
>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>> Cc: linux-fbdev@vger.kernel.org
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>  arch/arm/mach-omap1/board-osk.c         |    1 +
>>  arch/arm/mach-omap1/board-palmte.c      |    1 +
>>  arch/arm/mach-omap1/board-palmtt.c      |    1 +
>>  arch/arm/mach-omap1/board-palmz71.c     |    1 +
>>  arch/arm/plat-omap/include/plat/board.h |    7 -------
>>  drivers/video/backlight/omap1_bl.c      |    2 +-
>>  include/linux/platform_data/omap1_bl.h  |   11 +++++++++++
>>  7 files changed, 16 insertions(+), 8 deletions(-)
>>  create mode 100644 include/linux/platform_data/omap1_bl.h

[...]

>> diff --git a/include/linux/platform_data/omap1_bl.h b/include/linux/platform_data/omap1_bl.h
>> new file mode 100644
>> index 0000000..881a8e9
>> --- /dev/null
>> +++ b/include/linux/platform_data/omap1_bl.h
>> @@ -0,0 +1,11 @@
>> +#ifndef __OMAP1_BL_H__
>> +#define __OMAP1_BL_H__
>> +
>> +#include <linux/device.h>
> 
> You could use struct device; here.

Yes I know, but I don't think it is any better.

> 
>> +
>> +struct omap_backlight_config {
>> +	int default_intensity;
>> +	int (*set_power)(struct device *dev, int state);
>> +};
>> +
>> +#endif
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks!


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQPozJAAoJEBDE8YO64EfasmQP/2v38LY4t30rnl3jOvs6vvsa
RPFFQG1lxkFTpMHMkOvb4pW/k00IHxkcv2hRrGmoBWbEJqel7b0LyEFVV+M+uCSo
nCVsnd/Pu7jftCwC2Ggy2PBE16n+9I6UttN4Vsh7a8f2qwtXdOxL01xxyM7cVtn4
YQRhyVrKMiiKhNfKtvQV2V0npsVVksgnKm0K1zNRiZkTuKjZ4sJrliGYaU6B5F32
MHx31U0r1VbxZwOi9m19Ucyuf1CYvVKhlmeMop1fE4+3Dkt1708pMWOpK9iknMQU
m5cA+25a7YolDIluvfXlH+7hDFZixDUd5pFeJA0llaqOv2PSHGT0kYDOTmtRyKvD
D3mq22amwPlqgjXdxJMS5gckF6N3KrBjA3AHW4FpoTQjdCciiql3k+DMaRNM6Dzm
WjCCZBOQHy5dSRn6HzNo2iSP+B8mANh8eoJJAoyS3JJ+ihf4hiV1PEC9jXxWTg1H
M449feGQccXUfYj8pTlXtTXEk8L5x3kBlU9VMMzlA1kQN0VoFOQRhSl+UVdu2ckA
SPotVgiUCUzT9x1xEoIBjrz+kLAk0bYvRv2vUflzzH8lf+/MYz4UxDikSCsifpF1
s/5evCRgSUokm1VxlFEMLiUG0gb8FJR3TylJU4CD5U9dbkel2urKoE1zfc4LyPRT
ycdLeCP+C7ZcsaNApWMS
=kElj
-----END PGP SIGNATURE-----
