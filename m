From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 8/9] dmaengine: ti-dma-crossbar: Use enum for crossbar type
Date: Wed, 21 Sep 2016 10:31:13 +0300
Message-ID: <512e93da-9a25-01d5-4a71-07a48e28702d@ti.com>
References: <20160916083324.29133-1-peter.ujfalusi@ti.com>
 <20160916083324.29133-9-peter.ujfalusi@ti.com>
 <20160921035226.GE2609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160921035226.GE2609@localhost>
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
Cc: arnd@arndb.de, tony@atomide.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/21/16 06:52, Vinod Koul wrote:
> On Fri, Sep 16, 2016 at 11:33:23AM +0300, Peter Ujfalusi wrote:
>> Fixes compiler warning on 64bit architectures.
> =

> Would be good to give the warning message here

Let me revert this patch and patch #2 for the eDMA to get the warnings.

I will repost v2 with the updated commit messages.

> =

>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/ti-dma-crossbar.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar=
.c
>> index e4f3bd1ae264..876e4ccaf033 100644
>> --- a/drivers/dma/ti-dma-crossbar.c
>> +++ b/drivers/dma/ti-dma-crossbar.c
>> @@ -16,8 +16,10 @@
>>  #include <linux/of_device.h>
>>  #include <linux/of_dma.h>
>>  =

>> -#define TI_XBAR_DRA7		0
>> -#define TI_XBAR_AM335X		1
>> +enum ti_xbar_type {
>> +	TI_XBAR_DRA7 =3D 0,
>> +	TI_XBAR_AM335X,
>> +};
>>  =

>>  static const struct of_device_id ti_dma_xbar_match[] =3D {
>>  	{
>> @@ -395,7 +397,7 @@ static int ti_dra7_xbar_probe(struct platform_device=
 *pdev)
>>  =

>>  	xbar->dmarouter.dev =3D &pdev->dev;
>>  	xbar->dmarouter.route_free =3D ti_dra7_xbar_free;
>> -	xbar->dma_offset =3D (u32)match->data;
>> +	xbar->dma_offset =3D (enum ti_xbar_type)match->data;
>>  =

>>  	mutex_init(&xbar->mutex);
>>  	platform_set_drvdata(pdev, xbar);
>> @@ -428,7 +430,7 @@ static int ti_dma_xbar_probe(struct platform_device =
*pdev)
>>  	if (unlikely(!match))
>>  		return -EINVAL;
>>  =

>> -	switch ((u32)match->data) {
>> +	switch ((enum ti_xbar_type)match->data) {
>>  	case TI_XBAR_DRA7:
>>  		ret =3D ti_dra7_xbar_probe(pdev);
>>  		break;
>> -- =

>> 2.10.0
>>
> =



-- =

P=E9ter
