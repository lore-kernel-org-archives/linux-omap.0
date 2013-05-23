From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [net-next resend PATCH 1/6] net: cpsw: enhance pinctrl support
Date: Thu, 23 May 2013 14:44:48 +0530
Message-ID: <519DDE08.5080504@ti.com>
References: <1369130103-743-1-git-send-email-mugunthanvnm@ti.com> <1369130103-743-2-git-send-email-mugunthanvnm@ti.com> <20130522.235741.135665074490271750.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58942 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756588Ab3EWJPP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 05:15:15 -0400
In-Reply-To: <20130522.235741.135665074490271750.davem@davemloft.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, benoit.cousson@linaro.orgm, paul@pwsan.com, gururaja.hebbar@ti.com

On 5/23/2013 12:27 PM, David Miller wrote:
> From: Mugunthan V N <mugunthanvnm@ti.com>
> Date: Tue, 21 May 2013 15:24:58 +0530
>
>> +		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
>> +						PINCTRL_STATE_DEFAULT);
> This is not indented correctly.
>
> Argument on the second, and subsequent, lines of a function call
> must start at the first column after the openning parenthesis of
> the function call itself.
>
> Please audit for this problem in your entire patch series, fix
> it up, and resubmit the full set of patches.
>
> Thanks.
Will fix it and submit the patch.

Regards
Mugunthan V N
