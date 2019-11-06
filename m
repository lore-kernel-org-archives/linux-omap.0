From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 7/7] dt-bindings: PCI: Use IRQ flags for legacy PCI
 IRQ interrupts
Date: Wed, 6 Nov 2019 17:47:45 -0600
Message-ID: <20191106234745.GA29524@bogus>
References: <20191104163834.8932-1-andrew.murray@arm.com>
 <20191104163834.8932-8-andrew.murray@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191104163834.8932-8-andrew.murray@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Murray <andrew.murray@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Toan Le <toan@os.amperecomputing.com>, Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@axis.com, Kishon Vijay Abraham I <kishon@ti.com>, linux-rockchip@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rfi@lists.rocketboards.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-omap@vger.kernel.org

On Mon,  4 Nov 2019 16:38:21 +0000, Andrew Murray wrote:
> Replace magic numbers used to describe legacy PCI IRQ interrupts
> with #define.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  .../devicetree/bindings/pci/83xx-512x-pci.txt | 18 ++---
>  .../devicetree/bindings/pci/aardvark-pci.txt  | 10 +--
>  .../devicetree/bindings/pci/altera-pcie.txt   | 10 +--
>  .../bindings/pci/axis,artpec6-pcie.txt        | 10 +--
>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 10 +--
>  .../bindings/pci/faraday,ftpci100.txt         | 68 +++++++++----------
>  .../bindings/pci/fsl,imx6q-pcie.txt           | 10 +--
>  .../bindings/pci/hisilicon-pcie.txt           | 20 +++---
>  .../bindings/pci/host-generic-pci.txt         | 10 +--
>  .../devicetree/bindings/pci/kirin-pcie.txt    | 10 +--
>  .../bindings/pci/layerscape-pci.txt           | 10 +--
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 40 +++++------
>  .../devicetree/bindings/pci/mobiveil-pcie.txt |  8 +--
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  8 +--
>  .../bindings/pci/pci-thunder-pem.txt          | 10 +--
>  .../devicetree/bindings/pci/pcie-al.txt       |  4 +-
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 20 +++---
>  .../bindings/pci/ralink,rt3883-pci.txt        | 18 ++---
>  .../bindings/pci/rockchip-pcie-host.txt       | 10 +--
>  .../devicetree/bindings/pci/ti-pci.txt        | 10 +--
>  .../devicetree/bindings/pci/uniphier-pcie.txt | 10 +--
>  .../bindings/pci/v3-v360epc-pci.txt           | 34 +++++-----
>  .../devicetree/bindings/pci/versatile.txt     | 40 +++++------
>  .../devicetree/bindings/pci/xgene-pci-msi.txt | 10 +--
>  .../devicetree/bindings/pci/xgene-pci.txt     | 10 +--
>  .../bindings/pci/xilinx-nwl-pcie.txt          | 10 +--
>  .../devicetree/bindings/pci/xilinx-pcie.txt   | 20 +++---
>  27 files changed, 224 insertions(+), 224 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
