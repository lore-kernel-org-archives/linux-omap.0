From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net-next v2 00/20] net: ethernet: ti: clean up and
 optimizations
Date: Fri, 26 Apr 2019 14:20:15 -0700
Message-ID: <20190426142006.7c562ed1@cakuba.netronome.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 26 Apr 2019 20:12:22 +0300, Grygorii Strashko wrote:
> Hi All,
> 
> This is a preparation series for introducing new switchbase TI CPSW driver which
> was originally introduced [1][2] by Ilias Apalodimas <ilias.apalodimas@linaro.org> 
> and also discussed in private mails and at Netdev x13 confernce.
> 
> Following discussions and suggestions (mostly by Andrew and Ivan) we going
> to introduce the new driver which is operating in dual-emac mode
> by default, thus working as 2 individual network interfaces.
> When both interfaces joined the bridge - CPSW driver will enter a switch
> mode and discard dual_mac configuration. The CPSW will be switched back
> to dual_mac mode if any port leaves the bridge. All configuration is going to be
> implemented via switchdev API.
> 
> Hence overall change is already very big I'm sending prerequisite patches which
> are mostly minor fixes/clean ups and code refactoring to separate common parts
> to be reused by both drivers.
> Probably the most serious change from functional point of view is Patch 11.
> 
> These patches were NFS boot tetested on TI AM335x/AM437x/AM5xx boards.

FWIW I don't see anything too objectionable here, we will see if the
merging of the shared module bites us or not :)

One note - please try to keep your submissions under 16 patches in a
single series (that's 15 at most).
