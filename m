From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 01/16] ARM: OMAP2 Provide function to enable/disable uart clocks
Date: Wed, 20 Aug 2008 08:49:37 +0300
Message-ID: <87r68k6xse.fsf@trdhcp146196.ntc.nokia.com>
References: <1212803277-18007-1-git-send-email-tony@atomide.com>
	<1212803277-18007-2-git-send-email-tony@atomide.com>
	<20080819164013.GA17034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17560 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbYHTFtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 01:49:45 -0400
In-Reply-To: <20080819164013.GA17034@flint.arm.linux.org.uk> (ext Russell
	King's message of "Tue, 19 Aug 2008 17:40:13 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

"ext Russell King - ARM Linux" <linux@arm.linux.org.uk> writes:

> On Fri, Jun 06, 2008 at 06:47:42PM -0700, Tony Lindgren wrote:
>> This patch adds common function to enable/disable omap2/3 uart
>> clocks. Enabled uarts are passed by bootloader in atags and clocks f=
or
>> these enabled uarts are touched.
>
> In some ways, this patch is a good thing, in others it's outrageous.
>
>> -static struct clk * uart1_ick =3D NULL;
>> -static struct clk * uart1_fck =3D NULL;
>> -static struct clk * uart2_ick =3D NULL;
>> -static struct clk * uart2_fck =3D NULL;
>> -static struct clk * uart3_ick =3D NULL;
>> -static struct clk * uart3_fck =3D NULL;
>> +static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
>> +static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
>> =20
>>  static struct plat_serial8250_port serial_platform_data[] =3D {
>>  	{
>> -		.membase	=3D (char *)IO_ADDRESS(OMAP_UART1_BASE),
>> +		.membase	=3D (__force void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),
>
> __force in drivers is a big no no, immediate patch rejection.  Driver=
s
> do not use __force.
>
> The reason for adding __iomem is to pick up where people are doing
> stupid things with pointers, and __force is added in _private_ code
> (eg, functions supporting IO, mapping functions, etc) to provide a
> way of saying "this is part of the infrastructure and its permitted
> to do this conversion."
>
> The correct place for that cast, in its entirety, is inside the
> IO_ADDRESS macro.
>
>> @@ -71,7 +67,7 @@ static inline void serial_write_reg(struct plat_se=
rial8250_port *p, int offset,
>>  				    int value)
>>  {
>>  	offset <<=3D p->regshift;
>> -	__raw_writeb(value, (unsigned long)(p->membase + offset));
>> +	__raw_writeb(value, p->membase + offset);
>
> Good.
>
>> @@ -87,10 +83,27 @@ static inline void __init omap_serial_reset(stru=
ct plat_serial8250_port *p)
>>  	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 <<=
 0));
>>  }
>> =20
>> -void __init omap_serial_init()
>> +void omap_serial_enable_clocks(int enable)
>> +{
>> +	int i;
>> +	for (i =3D 0; i < OMAP_MAX_NR_PORTS; i++) {
>> +		if (uart_ick[i] && uart_fck[i]) {
>> +			if (enable) {
>> +				clk_enable(uart_ick[i]);
>> +				clk_enable(uart_fck[i]);
>> +			} else {
>> +				clk_disable(uart_ick[i]);
>> +				clk_disable(uart_fck[i]);
>> +			}
>> +		}
>> +	}
>> +}
>
> Urgh.  Why enable all clocks?  I thought OMAP was about being as lean
> and mean as possible as far as power management goes, so why enable
> everything and disable everything?

Not everything, just those that are marked as a enabled by a
bootloader. This mean basically serial-console uart. If all three omap
uarts are used as a serial console, then this function will
disable/enable clocks for all of them.

> Looking at the omapzoom tree, this function isn't even referenced by
> another part of the kernel, so maybe this function is just cruft?

This function is added for dynamic PM to have a mean to enable/disable
serial console clocks. My intention is to be able to have PM when
serial console is used without need to reboot the device and changing
atags from the bootloader. There are patches on linux-omap list which a=
re
using this. They are not pushed yet.

>
>> +		sprintf(name, "uart%d_ick", i+1);
>> +		uart_ick[i] =3D clk_get(NULL, name);
>> +		if (IS_ERR(uart_ick[i])) {
>> +			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
>> +			uart_ick[i] =3D NULL;
>> +		} else
>> +			clk_enable(uart_ick[i]);
>> +
>> +		sprintf(name, "uart%d_fck", i+1);
>> +		uart_fck[i] =3D clk_get(NULL, name);
>> +		if (IS_ERR(uart_fck[i])) {
>> +			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
>> +			uart_fck[i] =3D NULL;
>> +		} else
>> +			clk_enable(uart_fck[i]);
>
> Definitely an improvement, but still some way to go yet... but not a
> reason not to get this in (once the above issues have been resolved.)
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
