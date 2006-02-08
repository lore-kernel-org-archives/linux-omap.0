From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Convert drivers to new irq trigger modes
Date: Wed, 08 Feb 2006 20:10:44 +0100
Message-ID: <43EA4234.4070807@gmail.com>
References: <43E8D9CA.8000204@gmail.com>
	<20060208051451.GA22845@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060208051451.GA22845@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Juha,

Juha Yrj=F6l=E4 wrote:
> Hi Dirk,
>=20
> On Tue, Feb 07, 2006 at 06:32:58PM +0100, ext Dirk Behme wrote:
>=20
>>  	int			irq;
>> +	int			irq_type;
>=20
> This doesn't seem to be used anywhere.

To which file do you refer here? isp1301_omap.c, tps65010.c=20
or omap_ts.h? I use irq_type in all of them.

I thought I use irq_type in all three files: isp->irq_type,=20
  tps->irq_type and ts->irq_type?

>> +	isp->irq_type =3D SA_SAMPLE_RANDOM;
>>  	isp->client.addr =3D address;
>>  	i2c_set_clientdata(&isp->client, isp);
>>  	isp->client.adapter =3D bus;
>> @@ -1602,7 +1604,7 @@ fail1:
>>  		isp->irq =3D OMAP_GPIO_IRQ(2);
>>  		omap_request_gpio(2);
>>  		omap_set_gpio_direction(2, 1);
>> -		set_irq_type(isp->irq, IRQT_FALLING);
>> +		isp->irq_type =3D SA_TRIGGER_FALLING;
>=20
> You should be ORring here.  Otherwise you lose the SA_SAMPLE_RANDOM fla=
g.

It is intended to lose SA_SAMPLE_RANDOM here.=20
SA_SAMPLE_RANDOM is the default and shall be used by=20
request_irq() on boards which don't need special trigger=20
setting. But on boards which need special trigger level=20
setting this shall be overridden by the correct setting.

Best regards

Dirk
