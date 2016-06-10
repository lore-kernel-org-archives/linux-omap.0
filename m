From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: DRA7: Update to latest TRM and cleanup
Date: Fri, 10 Jun 2016 02:34:00 -0700
Message-ID: <20160610093359.GQ22406@atomide.com>
References: <1464096940-27145-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464096940-27145-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Nishanth Menon <nm@ti.com> [160524 06:37]:
> Hi,
> 
> Here are the final(hopefully) pending patches for DRA7 based on recent
> TRM updates. Updates include removing retention support on L3init and
> L4per as per latest SoC updates.
> 
> Test Log: X15 (no modules): http://pastebin.ubuntu.com/16655027/
> 
> Latest TRM (rev F): http://www.ti.com/lit/pdf/spruhz6 (public on May 18)
> 
> Nishanth Menon (3):
>   ARM: OMAP: DRA7: powerdomain data: Set L3init and L4per to ON
>   ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_logic_ret
>   ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret
> 
>  arch/arm/mach-omap2/powerdomains7xx_data.c | 76 +-----------------------------
>  1 file changed, 2 insertions(+), 74 deletions(-)

Can these wait until v4.8 merge window, are this needed as fixes to
avoid hardware problems?

Regards,

Tony
