From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net-next 02/19] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
Date: Tue, 23 Apr 2019 17:27:09 -0700
Message-ID: <20190423172709.693f4784@cakuba.netronome.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
        <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 23 Apr 2019 16:08:53 +0300, Grygorii Strashko wrote:
> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
> config option.
> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
> make build work.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Last time I tried including the same object file in two different
modules it backfired pretty badly.  Would you mind sparing some 
details as to why you need to do this?
