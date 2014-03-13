From: sourav <sourav.poddar@ti.com>
Subject: Re: [PATCHv3 1/2] arm: dts: dra7: Add qspi device.
Date: Thu, 13 Mar 2014 10:12:55 +0530
Message-ID: <5321374F.9040707@ti.com>
References: <1394452263-12975-1-git-send-email-sourav.poddar@ti.com> <20140312173444.GF30897@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50127 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaCMEm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 00:42:59 -0400
In-Reply-To: <20140312173444.GF30897@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Tony,

On Wednesday 12 March 2014 11:04 PM, Tony Lindgren wrote:
> * Sourav Poddar<sourav.poddar@ti.com>  [140310 04:54]:
>> These add device tree entry for qspi controller driver on dra7-evm.
> It seems that we need to wait for the crossbar dependencies
> to get cleared in the mainline kernel before we can apply this
> as otherwise the interrupts will be wrong in omap-for-v3.15/dt
> branch.
>
> Regards,
>
> Tony

Ok.
Can patch2 of this series be picked? It does not depend on crossbar and 
is targetted for
a different SOC(AM43x).
