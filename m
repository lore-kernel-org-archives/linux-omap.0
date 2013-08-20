From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCHv10] drivers: spi: Add qspi flash controller
Date: Tue, 20 Aug 2013 18:48:02 +0530
Message-ID: <52136C8A.1020000@ti.com>
References: <1377003925-6284-1-git-send-email-sourav.poddar@ti.com> <20130820131429.GB26587@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44719 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab3HTNSX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Aug 2013 09:18:23 -0400
In-Reply-To: <20130820131429.GB26587@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org

On Tuesday 20 August 2013 06:44 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Aug 20, 2013 at 06:35:25PM +0530, Sourav Poddar wrote:
>> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>> +{
>> +	int ret;
>> +
>> +	if (t->tx_buf) {
>> +		ret = qspi_write_msg(qspi, t);
>> +		if (ret) {
>> +			dev_dbg(qspi->dev, "Error while writing\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (t->rx_buf) {
>> +		ret = qspi_read_msg(qspi, t);
>> +		if (ret) {
>> +			dev_dbg(qspi->dev, "Error while writing\n");
> *READING*
>
hmm..got missed while folding local changes:(.
Will submit an updated patch.
> other than that:
>
> Acked-by: Felipe Balbi<balbi@ti.com>
> Reviewed-by: Felipe Balbi<balbi@ti.com>
>
Thanks!

