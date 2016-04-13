From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/7] ARM: OMAP2+: gpmc-nand: Set omap2-nand's parent
 dev to GPMC dev
Date: Wed, 13 Apr 2016 12:40:27 -0700
Message-ID: <20160413194027.GZ5995@atomide.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
 <1457654203-20856-2-git-send-email-fcooper@ti.com>
 <56E2CDB7.2080306@ti.com>
 <56E2E6B0.5050507@ti.com>
 <56E68143.9040903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56E68143.9040903@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "Franklin S Cooper Jr." <fcooper@ti.com>, nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [160314 02:16]:
> 
> I think it is OK to assume that NAND DMA won't work with legacy boot.
> Tony any objections? I see that board-ldp.c is the only legacy user
> of NAND. When can we drop support for it?

Sorry for the delay, just nocied this one. Let's not touch the
board-*.c files until we just remove them except for fixes.
It's OK to assume legacy booting does not support DMA.

Regards,

Tony
