From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] arm: dra7: Add i2c6 instance hwmod and dt entries
Date: Wed, 25 May 2016 11:09:50 -0500
Message-ID: <5745CE4E.3020903@ti.com>
References: <20160525125341.10044-1-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525125341.10044-1-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikumar Kattekola <rk@ti.com>, paul@pwsan.com, tony@atomide.com, linux@armlinux.org.uk, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 05/25/2016 07:53 AM, Ravikumar Kattekola wrote:
> DRA72x devices have a sixth i2c ocntroller instance.
> Following patches add the required hwmod structure and
> device tree nodes.
> 
> Reference doc: DRA72x TRM [ SPRUHP2Q ]
> 
> Tested on :
> DRA72x Rev B EVM
> 
> Ravikumar Kattekola (2):
>   arm: dra7: Add hwmod entry for i2c6
>   dts: dra7: Add device tree node for i2c6
> 
>  arch/arm/boot/dts/dra7.dtsi               | 11 +++++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 23 +++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
NAK. reasoning:
a) i2c6 is a custom IP integration with completely non-standard
dependencies with cross device dependencies for pretty much a specific
usecase -> usage is pretty much limited for generic support - the
decision is NOT to support this instance in Linux kernel - internal
discussion forwarded to developer.
b) the patches themselves are wrong -> it applies to DRA72x not
generic DRA7x platform
c) patches themselves are in the wrong format (wrong subject line etc).
d) patches don't handle the SoC internal device dependencies either ->
in short will not function in a generic solution for all variations of
platforms.

-- 
Regards,
Nishanth Menon
