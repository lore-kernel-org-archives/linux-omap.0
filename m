From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv9 05/18] mfd: omap-prm: add driver skeleton
Date: Fri, 18 Nov 2011 13:35:56 -0800
Message-ID: <4EC6CFBC.3090502@deeprootsystems.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com> <1316781986-30642-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316781986-30642-6-git-send-email-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 09/23/2011 05:46 AM, Tero Kristo wrote:
> This driver will eventually support OMAP soc PRM module features, e.g. PRCM
> chain interrupts and voltage processor / controller. This patch only adds
> basic skeleton for the driver that can be probed for omap3 and omap4.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

> +config OMAP_PRM
> +	bool "OMAP Power and Reset Management driver"
> +	depends on (ARCH_OMAP) && PM

Minor: this should probably be

	default ARCH_OMAP && PM

So it's enabled by default whenever a PM kernel is built for OMAP.

Kevin
