From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 9 /12 ] Plat-omap files updating to support OMAP3
Date: Thu, 14 Jun 2007 16:27:22 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470123C582@dlee13.ent.ti.com>
References: <20070614115821.GH28804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070614115821.GH28804@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

>> --- linux-omap/arch/arm/plat-omap/gpio.c	2007-05-07
>20:57:49.000000000 -0500
>> +++ val_3430_GIT/arch/arm/plat-omap/gpio.c	2007-06-13
>16:45:33.000000000 -0500
>...
>> @@ -1290,7 +1328,7 @@ static int __init _omap_gpio_init(void)
>>  				clk_enable(gpio5_fck);
>>  		}
>>  #endif
>> -}
>> +	}
>>
>>  #ifdef CONFIG_ARCH_OMAP15XX
>>  	if (cpu_is_omap15xx()) {
>
>Is the formatting change above correct?
>
Double Checked, the formatting is correct...

Regards,
Khasim
