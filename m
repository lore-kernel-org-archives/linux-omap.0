From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] doc: dt: mtd: add w25q64 to list of supported SPI
 flashes
Date: Wed, 15 Mar 2017 14:13:49 -0500
Message-ID: <20170315191349.mxh2ahnhn2uhyvm4@rob-hp-laptop>
References: <20170307215751.29266-1-fcooper@ti.com>
 <20170307215751.29266-2-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170307215751.29266-2-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: devicetree@vger.kernel.org, tony@atomide.com, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 07, 2017 at 03:57:50PM -0600, Franklin S Cooper Jr wrote:
> From: Sekhar Nori <nsekhar@ti.com>
> 
> W25Q64 is found on TI's AM335x ICEv2 board. Add it to list
> for supported SPI flash devices. This flash can be identified
> using JEDEC READ ID opcode.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
