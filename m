From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: omap2plus_defconfig: Enable OMAP3 ISP and
 dependencies
Date: Mon, 22 Feb 2016 10:11:29 -0800
Message-ID: <20160222181128.GM13417@atomide.com>
References: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [160208 09:54]:
> Hello,
> 
> This small series enables all the Kconfig symbols needed to test the
> OMAP3 ISP on the IGEPv2 board. I've enabled as much as possible as a
> module and only as built-in the options that are boolean.

Looks good to me thanks, applying into omap-for-v4.6/defconfig.

Tony
