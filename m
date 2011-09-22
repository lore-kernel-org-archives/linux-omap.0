From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/3] AM35x: Using OMAP3 generic hwmods
Date: Thu, 22 Sep 2011 13:10:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109221303530.10719@utopia.booyaka.com>
References: <1316697993-696-1-git-send-email-abhilash.kv@ti.com> <1316697993-696-2-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316697993-696-2-git-send-email-abhilash.kv@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, "Maupin, Chase" <chase.maupin@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, aneesh@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, christian.gmeiner@gmail.com
List-Id: linux-omap@vger.kernel.org

+ Chase

Hi

On Thu, 22 Sep 2011, Abhilash K V wrote:

> This patch enables AM35x SoCs to use generic OMAP3 hwmods
> (i,e. omap3xxx_hwmods) by allowing am35xx_init_early() to
> disable the modules which are not present in AM3517.
> 
> Reviewed-by: Sanjeev Premi <premi@ti.com>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>

We now use a different approach for registering hwmods that are 
device-specific.  Could you please take a look at the approach that's in 
Tony's master branch and use it instead to handle AM3517 hwmod 
registration?

- Paul
