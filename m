From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] ARM: OMAP: I2C: fix compilation when !CONFIG_OF
Date: Sun, 22 Jan 2012 08:46:48 -0700
Message-ID: <CACxGe6vmPLi0e0CmJtKhFe9dHHt5mgKQ_A1NPyFSJvqLbk7v=w@mail.gmail.com>
References: <20120122105942.6508.82335.stgit@dusk> <20120122110232.6508.68451.stgit@dusk>
 <4F1C2DEB.50209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48839 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab2AVPrJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jan 2012 10:47:09 -0500
Received: by pbaa10 with SMTP id a10so1226044pba.19
        for <linux-omap@vger.kernel.org>; Sun, 22 Jan 2012 07:47:09 -0800 (PST)
In-Reply-To: <4F1C2DEB.50209@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>

On Sun, Jan 22, 2012 at 8:40 AM, Rob Herring <robherring2@gmail.com> wr=
ote:
> On 01/22/2012 05:02 AM, Paul Walmsley wrote:
>> Commit 6145197be6cc0583fa1a2f4ec1079d366137061e ("i2c: OMAP: Add DT
>> support for i2c controller") breaks compilation when CONFIG_OF is no=
t
>> defined:
>>
>> =A0 CC =A0 =A0 =A0drivers/i2c/busses/i2c-omap.o
>> drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
>> drivers/i2c/busses/i2c-omap.c:1021:26: error: 'omap_i2c_of_match' un=
declared (first use in this function)
>> drivers/i2c/busses/i2c-omap.c:1021:26: note: each undeclared identif=
ier is reported only once for each function it appears in
>>
>> Fix this by avoiding of_*() functions when !CONFIG_OF.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A04 +++-
>> =A01 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index f713eac..1008e96 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -989,7 +989,7 @@ omap_i2c_probe(struct platform_device *pdev)
>> =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *mem, *irq, *ioarea;
>> =A0 =A0 =A0 struct omap_i2c_bus_platform_data *pdata =3D pdev->dev.p=
latform_data;
>> =A0 =A0 =A0 struct device_node =A0 =A0 =A0*node =3D pdev->dev.of_nod=
e;
>> - =A0 =A0 const struct of_device_id *match;
>> + =A0 =A0 const struct of_device_id *match =3D NULL;
>> =A0 =A0 =A0 irq_handler_t isr;
>> =A0 =A0 =A0 int r;
>>
>> @@ -1018,7 +1018,9 @@ omap_i2c_probe(struct platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
>> =A0 =A0 =A0 }
>>
>> +#ifdef CONFIG_OF
>> =A0 =A0 =A0 match =3D of_match_device(omap_i2c_of_match, &pdev->dev)=
;
>> +#endif
>
> How about an empty function for of_match_device instead to avoid the =
ifdef.

That already exists.  The problem is the undefined omap_i2c_of_match
table reference.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
