From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/9] dmaengine: edma: Use enum for eDMA binding type
 (legacy vs TPCC)
Date: Wed, 21 Sep 2016 14:07:22 +0300
Message-ID: <bbd248d1-223c-00a9-3d2a-33df085c4f68@ti.com>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
 <20160921102637.24845-3-peter.ujfalusi@ti.com> <7753810.Z3F41qkFaI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7753810.Z3F41qkFaI@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, tony@atomide.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/21/16 13:31, Arnd Bergmann wrote:
> On Wednesday, September 21, 2016 1:26:30 PM CEST Peter Ujfalusi wrote:
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index c2098a4b4dcf..4c8818278fcc 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -261,8 +261,11 @@ static const struct edmacc_param dummy_paramset =3D=
 {
>>         .ccnt =3D 1,
>>  };
>>  =

>> -#define EDMA_BINDING_LEGACY    0
>> -#define EDMA_BINDING_TPCC      1
>> +enum edma_binding_type {
>> +       EDMA_BINDING_LEGACY =3D 0,
>> +       EDMA_BINDING_TPCC,
>> +};



>> +
>>  static const struct of_device_id edma_of_ids[] =3D {
>>         {
>>                 .compatible =3D "ti,edma3",
>> @@ -2184,7 +2187,8 @@ static int edma_probe(struct platform_device *pdev)
>>                 const struct of_device_id *match;
>>  =

>>                 match =3D of_match_node(edma_of_ids, node);
>> -               if (match && (u32)match->data =3D=3D EDMA_BINDING_TPCC)
>> +               if (match &&
>> +                   (enum edma_binding_type)match->data =3D=3D EDMA_BIND=
ING_TPCC)
>>                         legacy_mode =3D false;
>>  =

>>                 info =3D edma_setup_info_from_dt(dev, legacy_mode);
>> -- =

>> 2.10.0
>>
> =

> Are you sure this works on all architectures? IIRC the size of an enum
> is implementation defined, so this could still fail sometimes.

True, some arch have HW type for enum or something similar.

> =

> I tend to use 'uintptr_t' for the cast instead.

What about keeping the defines and:

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3e9606b08340..493fdf30e8b8 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -263,14 +263,19 @@ static const struct edmacc_param dummy_paramset =3D {

 #define EDMA_BINDING_LEGACY	0
 #define EDMA_BINDING_TPCC	1
+static const u32 edma_binding_type[] =3D {
+	[EDMA_BINDING_LEGACY] =3D EDMA_BINDING_LEGACY,
+	[EDMA_BINDING_TPCC] =3D EDMA_BINDING_TPCC,
+};
+
 static const struct of_device_id edma_of_ids[] =3D {
 	{
 		.compatible =3D "ti,edma3",
-		.data =3D (void *)EDMA_BINDING_LEGACY,
+		.data =3D (void *)&edma_binding_type[EDMA_BINDING_LEGACY],
 	},
 	{
 		.compatible =3D "ti,edma3-tpcc",
-		.data =3D (void *)EDMA_BINDING_TPCC,
+		.data =3D (void *)&edma_binding_type[EDMA_BINDING_TPCC],
 	},
 	{}
 };
@@ -2183,7 +2188,7 @@ static int edma_probe(struct platform_device *pdev)
 		const struct of_device_id *match;

 		match =3D of_match_node(edma_of_ids, node);
-		if (match && (u32)match->data =3D=3D EDMA_BINDING_TPCC)
+		if (match && (*(u32*)match->data) =3D=3D EDMA_BINDING_TPCC)
 			legacy_mode =3D false;

 		info =3D edma_setup_info_from_dt(dev, legacy_mode);


same for the ti-dma-crossbar.

-- =

P=E9ter
