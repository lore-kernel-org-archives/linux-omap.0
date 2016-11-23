From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: AM571x-IDK Initial Support
Date: Wed, 23 Nov 2016 17:02:17 -0600
Message-ID: <20161123230217.iq5fyyazgzdaccqv@rob-hp-laptop>
References: <20161122041732.8385-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161122041732.8385-1-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, spatton@ti.com, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2016 at 09:47:32AM +0530, Lokesh Vutla wrote:
> From: Schuyler Patton <spatton@ti.com>
> 
> The AM571x-IDK board is a board based on TI's AM5718 SOC
> which has a single core 1.5GHz A15 processor. This board is a
> development platform for the Industrial market with:
> - 1GB of DDR3L
> - Dual 1Gbps Ethernet
> - HDMI,
> - PRU-ICSS
> - uSD
> - 16GB eMMC
> - CAN
> - RS-485
> - PCIe
> - USB3.0
> - Video Input Port
> - Industrial IO port and expansion connector
> 
> The link to the data sheet and TRM can be found here:
> 
> http://www.ti.com/product/AM5718
> 
> Initial support is only for basic peripherals.
> 
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Cahnges since v1:
> - Dropped "ti,dra722", and "ti,dra72" from compatibles
> - Fixes few node names as suggested by Rob.
> Logs: http://pastebin.ubuntu.com/23515001/
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |  3 +
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/am571x-idk.dts                   | 81 ++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am571x-idk.dts

Acked-by: Rob Herring <robh@kernel.org>
