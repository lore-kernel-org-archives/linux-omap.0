From: Luciano Coelho <coelho@ti.com>
Subject: Re: Regression 3.11-rc1: omap4panda: no usb and consequently no
 ethernet
Date: Sat, 20 Jul 2013 10:38:10 +0300
Message-ID: <1374305890.8385.53.camel@cumari.coelho.fi>
References: <51E7AA24.6080600@broadcom.com>
	 <20130718085951.GT7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130718085951.GT7656@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arend van Spriel <arend@broadcom.com>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-07-18 at 01:59 -0700, Tony Lindgren wrote:
> * Arend van Spriel <arend@broadcom.com> [130718 01:47]:
> Then for the SDIO with device tree, take a look at the following
> patches:
> 
> [PATCH 0/3] WLAN support for omap4 when booted with devicetree
> http://comments.gmane.org/gmane.linux.ports.arm.omap/97522#
> 
> The wl12xx .dts changes for pandaboard are still missing too.

Just for the record, I already have the DTS patches for wl12xx on Panda
(and a few other boards).

I held them back because I wanted the bindings to be properly defined
first.  I'll continue this work pretty soon, when I come back from my
summer vacations (in a week).

--
Cheers,
Luca.
