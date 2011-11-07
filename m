From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
Date: Mon, 7 Nov 2011 12:35:15 -0800
Message-ID: <20111107203515.GY31337@atomide.com>
References: <1320303638.17983.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320303638.17983.5.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Axel Lin <axel.lin@gmail.com> [111102 23:26]:
> Include linux/export.h to fix below build warning:
> 
>   CC      arch/arm/plat-omap/omap_device.o
> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration

Applying into fixes thanks.

Tony
