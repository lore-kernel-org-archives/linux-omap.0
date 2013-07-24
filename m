From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] mtd: nand: omap2: Fix compilation warning
Date: Wed, 24 Jul 2013 17:48:55 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9ED5F3@DBDE04.ent.ti.com>
References: <1374681392-6183-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374681392-6183-1-git-send-email-olof@lixom.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Olof,

> 
> fb1585bc13b (mtd: nand: omap2: clean-up BCHx_HW and BCHx_SW ECC
> configurations in device_probe) introduced a warning when the new option
> is disabled, i.e. with omap2plus_defconfig:
> 
> drivers/mtd/nand/omap2.c:1075:13: warning: 'omap3_enable_hwecc_bch'
> defined but not used [-Wunused-function]
> 
> Fix this by rescoping the ifdef. Also remove a redudant #endif/#ifdef
> pair.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---

Thanks much..
But just to remind, this commit fb1585b in linux-next needs to be reverted.
This patch is leftover by mistake because other dependent patches of 
this series were dropped. This will not only break omap2-nand driver,
but might also break the build.

http://lists.infradead.org/pipermail/linux-mtd/2013-July/047441.html

Please let me know, if something needs to be done from my-side to
get this reverted. I have already re-sent a updated version of this series
with fixes & copying devicetree-discuss.

http://lists.infradead.org/pipermail/linux-mtd/2013-July/047530.html


with regards, pekon
