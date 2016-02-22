From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: am43x-epos-evm: Add the am438 compatible
 string
Date: Sun, 21 Feb 2016 20:54:54 -0600
Message-ID: <20160222025454.GP15973@rob-hp-laptop>
References: <1455773381-11839-1-git-send-email-j-keerthy@ti.com>
 <1455773381-11839-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455773381-11839-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 18, 2016 at 10:59:40AM +0530, Keerthy wrote:
> The SoCs on am43x-epos-evm are named am438x.
> Hence add the compatibility string and remove the am4372 string.

Presumably nothing is using these strings ATM for matching.

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts                | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
