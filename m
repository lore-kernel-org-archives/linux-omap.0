From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [RFC/PATCH 2/2] driver: spi: Add quad spi read support
Date: Mon, 29 Jul 2013 15:13:07 +0530
Message-ID: <51F6392B.8030809@ti.com>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com> <1375082550-30544-3-git-send-email-sourav.poddar@ti.com> <20130729093258.GF23710@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59740 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab3G2JnX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 05:43:23 -0400
In-Reply-To: <20130729093258.GF23710@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

On Monday 29 July 2013 03:02 PM, Felipe Balbi wrote:
> On Mon, Jul 29, 2013 at 12:52:30PM +0530, Sourav Poddar wrote:
>> Since, qspi controller uses quad read.
>>
>> Configuring the command register, if the transfer of data needs
>> dual or quad lines.
>>
>> This patch has been done on top of the following patch[1], which is just the
>> basic idea of adding dual/quad support in spi framework.
>> $subject patch will undergo changes with the ongoing discussion in the
>> community.
>>
>> This patch is posted to demonstrate how patch 1 of the series will support
>> quad read.
>>
>> [1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047
>>
>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>> ---
>>   drivers/spi/spi-ti-qspi.c |   16 ++++++++++++++--
>>   1 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>> index 51fe95f..8a32b1c 100644
>> --- a/drivers/spi/spi-ti-qspi.c
>> +++ b/drivers/spi/spi-ti-qspi.c
>> @@ -86,6 +86,7 @@ struct ti_qspi {
>>   #define QSPI_3_PIN			(1<<  18)
>>   #define QSPI_RD_SNGL			(1<<  16)
>>   #define QSPI_WR_SNGL			(2<<  16)
>> +#define	QSPI_RD_DUAL			(3<<  16)
>>   #define QSPI_RD_QUAD			(7<<  16)
> so RD_QUAD is defined in previous patch but not RD_DUAL ? What gives ?
>
I think I will define RD_DUAL in the previous patch...
> IMHO, just merge this patch with previous and make the entire driver
> depend on the other patch.
>
but I was thinking of keeping rest of the $subject patch seperate, since the
idea of implementing dual/quad read in spi framework is still under 
discussion.
and this patch will change.

So, it would be good if we can get the basic previous patch in, and then 
when the
other discussion is sorted out, we can get this in?

~Sourav

