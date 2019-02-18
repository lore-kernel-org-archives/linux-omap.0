From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 09/14] dt-binding: remoteproc: Add binding doc for PRU
 Cores in the PRU-ICSS
Date: Mon, 18 Feb 2019 13:36:23 -0600
Message-ID: <20190218193623.GA20566@bogus>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-10-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549290167-876-10-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, 4 Feb 2019 16:22:42 +0200, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) consists of
> dual 32-bit RISC cores (Programmable Real-Time Units, or PRUs)
> for program execution. This patch adds a remoteproc platform
> driver for managing the individual PRU RISC cores life cycle.
> 
> Add DT binding documentation for that.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../bindings/remoteproc/ti,pru-rproc.txt           | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
