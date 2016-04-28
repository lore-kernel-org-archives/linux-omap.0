From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 5/9] ARM: dts: am437x/am33xx/da850: Add new ECAP and
 EPWM bindings
Date: Thu, 28 Apr 2016 16:35:45 -0500
Message-ID: <20160428213545.GA28119@rob-hp-laptop>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
 <1461710209-6563-6-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461710209-6563-6-git-send-email-fcooper@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: thierry.reding@gmail.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 05:36:45PM -0500, Franklin S Cooper Jr wrote:
> Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> provide the various required clocks.
> 
> For AM437 and AM335x, add the required clocks explicitly to DT. The
> hwmod entries for ECAP and EPWM will be removed and this will prevent
> anything from breaking.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         | 18 +++++---
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       | 18 +++++---
>  arch/arm/boot/dts/am33xx.dtsi                      | 30 +++++++++---
>  arch/arm/boot/dts/am4372.dtsi                      | 54 ++++++++++++++++++----
>  arch/arm/boot/dts/da850.dtsi                       | 15 ++++--
>  5 files changed, 103 insertions(+), 32 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
