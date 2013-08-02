From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH] mtd: nand: omap2: Fix compilation warning
Date: Fri, 02 Aug 2013 17:07:25 +0300
Message-ID: <1375452445.14869.324.camel@sauron.fi.intel.com>
References: <1374681392-6183-1-git-send-email-olof@lixom.net>
	 <20980858CB6D3A4BAE95CA194937D5E73E9ED5F3@DBDE04.ent.ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9ED5F3@DBDE04.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Olof Johansson <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2013-07-24 at 17:48 +0000, Gupta, Pekon wrote:
> Hi Olof,
> 
> > 
> > fb1585bc13b (mtd: nand: omap2: clean-up BCHx_HW and BCHx_SW ECC
> > configurations in device_probe) introduced a warning when the new option
> > is disabled, i.e. with omap2plus_defconfig:
> > 
> > drivers/mtd/nand/omap2.c:1075:13: warning: 'omap3_enable_hwecc_bch'
> > defined but not used [-Wunused-function]
> > 
> > Fix this by rescoping the ifdef. Also remove a redudant #endif/#ifdef
> > pair.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> 
> Thanks much..
> But just to remind, this commit fb1585b in linux-next needs to be reverted.
> This patch is leftover by mistake because other dependent patches of 
> this series were dropped. This will not only break omap2-nand driver,
> but might also break the build.

Just dropped it, thanks!

-- 
Best Regards,
Artem Bityutskiy
