From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] drivers: mtd: spinand: Add generic spinand frameowrk
	and micron driver.
Date: Thu, 27 Jun 2013 10:21:21 +0530
Message-ID: <51CBC4C9.7080809@ti.com>
References: <1372232472-2641-1-git-send-email-sourav.poddar@ti.com>
	<1372232472-2641-2-git-send-email-sourav.poddar@ti.com>
	<20130626152243.GA9414@kpatel.netlogicmircro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130626152243.GA9414-+J/lxNz7zLijYOuY2elzOeoJsYJ2OyzEAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tqnguyen-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, manonuevo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kamlakant,
On Wednesday 26 June 2013 08:52 PM, Kamlakant Patel wrote:
> On Wed, Jun 26, 2013 at 01:11:10PM +0530, Sourav Poddar wrote:
>> From: Mona Anonuevo<manonuevo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
>>
>> This patch adds support for a generic spinand framework(spinand_mtd.c).
>> This frameowrk can be used for other spi based flash devices also. The idea
>> is to have a common model under drivers/mtd, as also present for other no spi
>> devices(there is a generic framework and device part simply attaches itself to it.)
>>
>> The generic frework will be used later by me for a SPI based spansion S25FL256 device.
>> The patch also contains a micron driver attaching itself to generic framework.
>>
>> Signed-off-by: Mona Anonuevo<manonuevo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Tuan Nguyen<tqnguyen-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
>> ----
>> [I picked this as a standalone patch, can split it into generic and device part
>> based on community feedback.]
>>
>>   drivers/mtd/Kconfig               |    2 +
>>   drivers/mtd/Makefile              |    2 +
>>   drivers/mtd/spinand/Kconfig       |   24 ++
>>   drivers/mtd/spinand/Makefile      |   10 +
>>   drivers/mtd/spinand/spinand_lld.c |  776 +++++++++++++++++++++++++++++++++++++
>>   drivers/mtd/spinand/spinand_mtd.c |  690 +++++++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h       |  155 ++++++++
>>   7 files changed, 1659 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/mtd/spinand/Kconfig
>>   create mode 100644 drivers/mtd/spinand/Makefile
>>   create mode 100644 drivers/mtd/spinand/spinand_lld.c
>>   create mode 100644 drivers/mtd/spinand/spinand_mtd.c
>>   create mode 100644 include/linux/mtd/spinand.h
>>
> I am working on Micron SPINAND(Micron MT29F1G01ZACH). I tried this patch, but it's not working.
> It is throwing following error message while mounting:
> [  260.232000] jffs2: cannot read OOB for EB at 00000000, requested 8 bytes, read 0 bytes, error -22
> mount: mounting /dev/mtdblock5 on /mnt/ failed: Input/output error
>
> I am working on it to fix into the driver, will send an updated patch with the fix.
>
Thanks for replying on this.
Since, this patch is already posted, I think it will be better if you post
the delta fix on top of this patch.
> Thanks,
> Kamlakant Patel
>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
