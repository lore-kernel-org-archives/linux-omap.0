From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH 0/9] drivers: dma: Add support for dma-channel router
Date: Sat, 8 Mar 2014 13:53:45 -0600
Message-ID: <CAL_JsqLF6Ey1t1BV4tnFcFK-KmOU9H2nQE+ZHoZRq2r_nRTxNw@mail.gmail.com>
References: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 7, 2014 at 6:16 AM, Sricharan R <r.sricharan@ti.com> wrote:
> In some SoCs the dma request lines from the peripherals are
> routed to the dma-controller through a crossbar. With this the
> dma controller's available request lines are shared between the
> peripherals.
>
> This adds support to register the crossbar router associated with
> a dma-channel and let the dma-controller driver map/unmap
> the peripheral dma crossbar line to dma-controller's request
> line.

This is not a unique concept and should follow some existing pattern.
Perhaps something like interrupt-map. For the dmas property, the
parent should be the crossbar and then the crossbar block has to
translate that into the DMA controller request. All the DMA ctrlr
request connections should be described in the crossbar node. In
theory, you could have chained crossbars. This should be documented as
part of the generic DMA binding.

There are also other similar IP like CoreSight CTI which are just
signal routers. So there is probably some possibility of common code
here.

Rob
