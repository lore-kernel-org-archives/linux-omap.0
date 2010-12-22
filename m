From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP2: Devkit8000: Use _cansleep GPIO functions for
 display reset lines
Date: Tue, 21 Dec 2010 17:54:04 -0800
Message-ID: <20101222015404.GO5829@atomide.com>
References: <1292926993.9611.10.camel@morsing>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1292926993.9611.10.camel@morsing>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: weber@corscience.de, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Daniel Morsing <daniel.morsing@gmail.com> [101221 02:22]:
> The display reset lines are connected to a TPS65930 which may sleep
> when changing GPIO values. Use the appropriate function to silence
> a nasty warning from gpiolib.
> 
> Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
> Acked-by: Thomas Weber <weber@corscience.de>

Thanks applying.

Tony
