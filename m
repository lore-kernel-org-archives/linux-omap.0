From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 0/5] ARM: dts: OMAP2+: use preprocessor for device trees
Date: Thu, 23 May 2013 12:00:22 -0400
Message-ID: <519E3D16.2090003@ti.com>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 23 May 2013 11:36 AM, Florian Vaussard wrote:
> Hello,
> 
> Following a similar proposal by Stephen Warren for tegra [1], this series
> makes use of the C preprocessor when compiling OMAP DT files, and
> accomplishes some improvements to improve overall readability.
> 
> Patch 1 is a preparation for the rest of the series.
> Patch 2 uses existing constants for GPIOs. Patch 3 does the same for
> IRQs. Patch 4 creates a new header for OMAP's padmux, and patch 5 uses
> it to simplify pinctrl DT.
> 
> For all targets, the .dtb files were diff-tested before and after
> applying the series to guarantee identity.
> 

> 
> Florian Vaussard (5):
>   ARM: dts: OMAP2+: use #include for all device trees
>   ARM: dts: OMAP2+: use existing constants for GPIOs
>   ARM: dts: OMAP4/5: use existing constants for IRQs
>   ARM: dts: OMAP2+: header file for pinctrl constants
>   ARM: dts: OMAP2+: use pinctrl constants
> 
I just quickly scanned the series and patches looks
good to my eyes. Its a nice clean-up to align OMAP
dts files with others.

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
