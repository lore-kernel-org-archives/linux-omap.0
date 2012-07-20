From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] net: ethernet: davinci_emac: add pm_runtime support
Date: Fri, 20 Jul 2012 18:52:20 +0530
Message-ID: <50095B8C.3050502@ti.com>
References: <1342736577-30477-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1342736577-30477-1-git-send-email-mgreer@animalcreek.com>
Sender: netdev-owner@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, David Miller <davem@davemloft.net>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: linux-omap@vger.kernel.org

+ Dave Miller and DaVinci list

Hi Mark,

On 7/20/2012 3:52 AM, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Add pm_runtime support to the TI Davinci EMAC driver.
> 
> CC: Sekhar Nori <nsekhar@ti.com>
> CC: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Tested on AM18x EVM using NFS root and suspend-to-RAM.

Acked-by: Sekhar Nori <nsekhar@ti.com>

> ---
> 
> a) This patch depends on a patch by Kevin Hilman that has been
>    accepted for 3.6 and is waiting in arm-soc/for-next:
>    ce9dcb8784611c50974d1c6b600c71f5c0a29308
>    (ARM: davinci: add runtime PM support for clock management)

Since the patch does not have any dependency as far as applying it is
concerned, I guess it can be queued through the network tree.

> 
> b) Applies on top of current k.o. master:
>    3e4b9459fb0e149c6b74c9e89399a8fc39a92b44
>    (Merge tag 'md-3.5-fixes' of git://neil.brown.name/md)

The patch will have to apply to net-next if it goes through the net tree.

Thanks,
Sekhar
