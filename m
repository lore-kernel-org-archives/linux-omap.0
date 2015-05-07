From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 3/8] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Thu, 7 May 2015 12:48:34 +0300
Message-ID: <554B34F2.5050306@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-4-git-send-email-peter.ujfalusi@ti.com>
 <20150504053851.GY3521@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150504053851.GY3521@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, tony@atomide.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, robh+dt@kernel.org, grant.likely@linaro.org, maxime.ripard@free-electrons.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/04/2015 08:38 AM, Vinod Koul wrote:
> On Thu, Apr 09, 2015 at 12:35:49PM +0300, Peter Ujfalusi wrote:
>> +int omap_dmaxbar_init(void)
>> +{
>> +	return platform_driver_register(&ti_dma_xbar_driver);
>> +}
>> +arch_initcall(omap_dmaxbar_init);
> All looks fine except this bit, I think I did point out this last time as
> well, though dont recall your answer. We rather depend on defered probe a=
nd
> not rely on module ordering.

Can not find my previous response in my mailbox anymore thanks to Thunderbi=
rd:
it corrupted all of my local mbox files when I did a backup from the server=
 :(

I don't think the deferred probing is working with dmaengine since we return
NULL in any case when the channel can not be requested for whatever reason.
The request calls are eating up the error code (if any) which is coming when
the channel is requested. With the exception of
dma_request_slave_channel_reason(), which will return the reason for the
failure, but most drivers are not using this.

There is also a fallback in dma_request_slave_channel_compat() if the chann=
el
can not be requested via of/acpi it will try to get the channel via legacy
mode also.

Should all drivers using DMA via dmaengine should return with -EPROBE_DEFER
from their probe if they can not get the DMA channel? Some drivers uses the
existence/non existence of the DMA resource as a means to decide to use DMA=
 or
PIO mode...

If the crossbar is not in the same initcall level we can have bad race
conditions also:
omap-dma can handle up to 127 DMA requests.
omap-dma is loaded but the crossbar driver is not.

A driver requests DMA for crossbar line 135:
We will have failure from of_dma_request_slave_channel() since the CB driver
is not yet loaded (returning with -EPROBE_DEFER), then the legacy call will
try to get the channel from the loaded DMA driver, but that is going to fail
as well (135 is not valid for omap-dma).

Another driver would request DMA for crossbar line 100:
The legacy call will actually find it a valid request and get the channel f=
rom
omap-dma driver, but this will not work in reality: the crossbar also need =
to
be configured to route the signal to the correct line.
This driver would think it has valid DMA, but in fact it has non working DM=
A.

-- =

P=E9ter
