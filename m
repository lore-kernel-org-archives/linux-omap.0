From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Fix warning due invalid RXKAD
 symbol value
Date: Tue, 26 Apr 2016 10:30:28 -0700
Message-ID: <20160426173027.GK5995@atomide.com>
References: <1461347599-32440-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461347599-32440-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [160422 10:54]:
> Commit 648af7fca159 ("rxrpc: Absorb the rxkad security module") changed
> the RXKAD Kconfig symbol from tristate to boolean but the commit didn't
> update the omap2plus_defconfig that was enabling CONFIG_RXKAD as module.
> 
> This leads to the following warning when using the omap2plus_defconfig:
> 
> arch/arm/configs/omap2plus_defconfig:112:warning: symbol value 'm' invalid for RXKAD

Thanks applying into omap-for-v4.7/defconfig.

Tony
