From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/7] dmaengine: of_dma: Support for DMA routers
Date: Thu, 26 Mar 2015 14:11:38 +0200
Message-ID: <5513F77A.4030005@ti.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com> <1426080210-841-2-git-send-email-peter.ujfalusi@ti.com> <20150326105018.GJ32683@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150326105018.GJ32683@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 03/26/2015 12:50 PM, Vinod Koul wrote:
> On Wed, Mar 11, 2015 at 03:23:24PM +0200, Peter Ujfalusi wrote:
>> DMA routers are transparent devices used to mux DMA requests from
>> peripherals to DMA controllers. They are used when the SoC integrate=
s more
>> devices with DMA requests then their controller can handle.
>> DRA7x is one example of such SoC, where the sDMA can hanlde 128 DMA =
request
>> lines, but in SoC level it has 205 DMA requests.
>>
>> The of_dma_router will be registered as of_dma_controller with speci=
al
>> xlate function and additional parameters and the code will translate=
 and
>> requests a DMA channel from the real DMA controller.
>> This way the router can be transparent for the system while remainin=
g generic
>> enough to be used in different environments.
>>
> Looks fine, was expecting a Documentation updates as well, but that c=
an come
> as follow up patch too

I have added the DT binding document since this series adds support for
routers for platforms booting with DT:

Documentation/devicetree/bindings/dma/dma.txt | 28 ++++++++

--=20
P=E9ter
