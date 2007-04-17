From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH / RFC] Basic OMAP2430 High speed I2C & Speed handling
	(final)
Date: Tue, 17 Apr 2007 16:07:58 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47B66E52@dlee13.ent.ti.com>
References: <20070417195619.GD26287@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070417195619.GD26287@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Thanks for the comments, my response below.

>
>Let's rewrite the the header a bit to leave out change log type
>comments, something like this would be better in general:
>
>Copyright (C) 2003 MontaVista Software, Inc.
>Copyright (C) 2004 - 2007 Texas Instruments
>Copyright (C) 2005 Nokia Corporation
>...
>
>Written by:
>...
>
>This will avoid getting comments like "change log should be in git"
>on LKML.
>
>

OK ... Is the below one correct?

/*
 * TI OMAP I2C master mode driver
 *
 * Copyright (C) 2003 MontaVista Software, Inc.
 * Copyright (C) 2005 Nokia Corporation
 * Copyright (C) 2004 - 2007 Texas Instruments.
 *
 * Written by:
 * 	Tony Lindgren <tony@atomide.com>=20
 * 	Imre Deak <imre.deak@nokia.com>
 * 	Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
 * 	Syed Khasim <x0khasim@ti.com>

>> +	else {
>> +		dev->fclk =3D clk_get(dev->dev, "i2c_fck");
>> +		if (IS_ERR(dev->fclk)) {
>> +			if (dev->iclk !=3D NULL) {
>> +				clk_put(dev->iclk);
>> +				dev->iclk =3D NULL;
>> +			}
>> +			dev->fclk =3D NULL;
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>
>Is the i2c_fck needed on 2430? If not, we could just rename i2chs_fck
>to i2c_fck in clock.h. Then just add a comment that i2c_fck is =
available
>for 2430 too, but i2chs_fck is the preferred one to use.
>

i2c_fck is available for 2430 but i2chs_fck is preferred to use. I will =
add this comment in clock.h?

>> +	else {
>> +		/* Program desired operating rate */
>> +		fclk_rate /=3D (psc + 1) * 1000;
>> +		if (psc > 2)
>> +			psc =3D 2;
>> +		scll =3D fclk_rate / (dev->speed * 2) - 7 + psc;
>> +		sclh =3D fclk_rate / (dev->speed * 2) - 7 + psc;
>> +	}
>
>According to CodingStyle else above should be on the same line with
>the brace. It's on separate lines in two places above.

Mistake :( , Will correct them.

>>
>>  	/* Enable interrupts */
>>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
>> -			   (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>> -			    OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
>> -			    OMAP_I2C_IE_AL));
>> +				(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>> +				OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
>> +				OMAP_I2C_IE_AL));
>>  	return 0;
>>  }
>
>Please separate formatting changes to a separate patch with no
>functional changes. Maybe one follow-up patch for the getting rid
>of the changelog in the header, and formatting changes?

OK, will send a patch with these two changes.

>> +#if defined(CONFIG_MACH_OMAP_2430SDP)
>> +static u32 omap2_i2c2_clkrate	=3D 2600;
>> +#else
>> +static u32 omap2_i2c2_clkrate	=3D 100;
>> +#endif
>> +
>
>The if defined(CONFIG_MACH_OMAP_2430SDP) adds an unnecessary dependency
>for not being possibly able to compile in multiple omaps. Let's rather
>just do something with if (cpu_is_omap2430()) to set the
>omap2_i2c2_clkrate.

This is a known problem that we were initially discussing. OMAP2430 has =
2 I2C blocks, on a given board any one of these can be configured for HS =
and other can be for FS/S. So the speed basically depends on the board =
and not on the processor. We have to move this to board file, but =
changing all board files for adding this definition is another problem. =
Please suggest.

>>  /* See also arch/arm/mach-omap2/devices.c for second I2C on 24xx */
>
>Same here with omap2_i2c1_clkrate.
>

Same this as above.

Regards,
Khasim
