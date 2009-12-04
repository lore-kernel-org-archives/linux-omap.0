From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2] omap: serial: fix non-empty uart fifo read abort
Date: Sat, 5 Dec 2009 00:45:06 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C9FC@dbde02.ent.ti.com>
References: <1259882986-11009-1-git-send-email-vikram.pandita@ti.com>
 <20091204190400.GF24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46371 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614AbZLDTPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 14:15:07 -0500
In-Reply-To: <20091204190400.GF24013@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Friday, December 04, 2009 1:04 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org; Cousson, Benoit
>Subject: Re: [PATCH v2] omap: serial: fix non-empty uart fifo read abort
>
<snip>
>> +
>> +#ifdef CONFIG_ARCH_OMAP4
>> +		/* Never read empty UART fifo on omap4 */
>> +		p->serial_in = serial_in_override;
>> +#else
>> +		/* OMAP2/3 */
>> +		/* Never read empty UART fifo on UARTs with IP rev >=0x52 */
>> +		if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
>> +				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
>> +			uart->p->serial_in = serial_in_override;
>> +#endif
>>  	}
>>  }
>
>We need to avoid ifdef else stuff, that just causes problems compiling
>in support for many omaps. In theory, we should be able to compile in
>support for all omaps starting with 16xx with v5 options..
>
>Using cpu_is_omapxxxx() should do the trick here.

The intent was to have check entirely based of UART IP revision.
That worked fine for omap3xxx. But omap4 has totally different IP revision register (as per commit message)

But I can see the point, and v3 of patch I can replace:
#ifdef CONFIG_ARCH_OMAP4 by cpu_is_omap44xx()

I tried following what was done in current serial.c file of many #ifdef CONFIG_ARCH_OMAP4


>
>Tony
