From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH net-next] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
Date: Fri, 29 Mar 2019 17:55:48 +0200
Message-ID: <2b50d7d7-ba17-af6f-4c5d-c84106176f1b@ti.com>
References: <1553794193-8098-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553794193-8098-1-git-send-email-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, linux-omap@vger.kernel.org
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 28.03.19 19:29, Grygorii Strashko wrote:
> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
> config option.
> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
> make build work.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> 
Sry, wrong patch version, ignore it please.

-- 
Best regards,
grygorii
