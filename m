From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 1/1] clk: ti: add support for external clock provider
Date: Mon, 4 Aug 2014 13:50:04 +0300
Message-ID: <53DF655C.9020409@ti.com>
References: <1406898948-26113-1-git-send-email-t-kristo@ti.com> <1406898948-26113-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57218 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbaHDKuz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2014 06:50:55 -0400
In-Reply-To: <1406898948-26113-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, sassmann@kpanic.de, peter.ujfalusi@ti.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/01/2014 04:15 PM, Tero Kristo wrote:
> External clock provider can now be used to register external clocks under
> it. This is needed as the TI clock driver only registers clocks
> hierarchically under clock providers, and external clocks do not belong
> under any of the current ones.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Tested-by: Jyri Sarha <jsahra@ti.com>



