From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw: add check for in-band mode
 setting with RGMII PHY interface
Date: Sat, 17 Mar 2018 19:50:41 -0400 (EDT)
Message-ID: <20180317.195041.149491190187125605.davem@davemloft.net>
References: <20180315165603.30471-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315165603.30471-1-sz.lin@moxa.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sz.lin@moxa.com
Cc: spatton@ti.com, grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, j-keerthy@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: SZ Lin (林上智) <sz.lin@moxa.com>
Date: Fri, 16 Mar 2018 00:56:01 +0800

> According to AM335x TRM[1] 14.3.6.2, AM437x TRM[2] 15.3.6.2 and
> DRA7 TRM[3] 24.11.4.8.7.3.3, in-band mode in EXT_EN(bit18) register is only
> available when PHY is configured in RGMII mode with 10Mbps speed. It will
> cause some networking issues without RGMII mode, such as carrier sense
> errors and low throughput. TI also mentioned this issue in their forum[4].
> 
> This patch adds the check mechanism for PHY interface with RGMII interface
> type, the in-band mode can only be set in RGMII mode with 10Mbps speed.
> 
> References:
> [1]: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
> [2]: http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf
> [3]: http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf
> [4]: https://e2e.ti.com/support/arm/sitara_arm/f/791/p/640765/2392155
> 
> Suggested-by: Holsety Chen (陳憲輝) <Holsety.Chen@moxa.com>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> Signed-off-by: Schuyler Patton <spatton@ti.com>

Applied and queued up for -stable, thank you.
