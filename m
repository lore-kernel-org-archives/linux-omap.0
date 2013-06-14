From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] mfd: Palmas: Introduce features to select the appropriate
 modules present in the palmas variant
Date: Fri, 14 Jun 2013 15:32:01 +0530
Message-ID: <51BAEA19.7070509@nvidia.com>
References: <1371201718-15101-1-git-send-email-j-keerthy@ti.com> <20130614095554.GF5456@mint>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:8695 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3FNJ6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 05:58:12 -0400
In-Reply-To: <20130614095554.GF5456@mint>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: J Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>

On Friday 14 June 2013 03:25 PM, Graeme Gregory wrote:
> On Fri, Jun 14, 2013 at 02:51:58PM +0530, J Keerthy wrote:
>> -	children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
>> -	children[PALMAS_PMIC_ID].pdata_size = sizeof(*pdata->pmic_pdata);
>> +	if (PALMAS_PMIC_HAS(palmas, REGULATORS)) {
>> +		children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
>> +		children[PALMAS_PMIC_ID].pdata_size =
>> +				sizeof(*pdata->pmic_pdata);
>> +	}
>>   
> I think a lot of complexity here could actually be removed by removing the
> old board file style probing for palmas. I do not beleive either major user
> of palmas requires that anymore? I always had in my mind that this bit
> was temporary.

Completely agree, we should not have this. Also this is not valid much 
in DT context and so we can remove it.

