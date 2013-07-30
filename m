From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 17/33] CLK: DT: add support for set-rate-parent flag
Date: Tue, 30 Jul 2013 14:58:02 -0500
Message-ID: <51F81ACA.7090501@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-18-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60545 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab3G3T6a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 15:58:30 -0400
In-Reply-To: <1374564028-11352-18-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> Adding set-rate-parent to clock node now allows a node to forward
> clk_set_rate request to its parent clock.

Apologies about previous comment of set-parent missing, the sequence of 
patches messed with me :(. had expected generic clk changes at the start 
of the series followed by the rest.

>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   drivers/clk/clk-divider.c      |    6 +++++-
>   drivers/clk/clk-fixed-factor.c |    6 +++++-
>   drivers/clk/clk-gate.c         |    8 ++++++--
>   drivers/clk/clk-mux.c          |    6 +++++-
>   4 files changed, 21 insertions(+), 5 deletions(-)

Documentation/devicetree/bindings/clock/ needs update as well.
[...]

-- 
Regards,
Nishanth Menon
