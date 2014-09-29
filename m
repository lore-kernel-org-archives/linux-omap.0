From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 06/16] tty: serial: Add 8250-core based omap driver
Date: Mon, 29 Sep 2014 15:27:12 +0200
Message-ID: <20140929132712.GD13142@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-7-git-send-email-bigeasy@linutronix.de>
 <20140929093823.GD13952@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140929093823.GD13952@ci00147.xsens-tech.local>
Sender: linux-serial-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Frans Klaver | 2014-09-29 11:38:23 [+0200]:

>threshold
fixed

>> +	/*
>> +	 * It claims to be 16C750 compatible however it is a little different.
>> +	 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
>> +	 * have) is enabled via EFR instead of MCR. The type is set here 8250
>> +	 * just to get things going. UNKNOWN does not work for a few reasons and
>> +	 * we don't need our own type since we don't use 8250's set_termios()
>> +	 * and our "bugs" are handeld via the bug member.
>
>handled
replaced that last line with 
    or pm callback.

since there no bugs member anymore.

>
>> +	 */
>> +	up.port.type = PORT_8250;
>> +	up.port.iotype = UPIO_MEM;
>> +	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW |
>> +		UPF_HARD_FLOW;
>> +	up.port.private_data = priv;
>> +
>> +	up.port.regshift = 2;
>> +	up.port.fifosize = 64;
>> +	up.tx_loadsz = 64;
>> +	up.capabilities = UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP;
>> +#ifdef CONFIG_PM_RUNTIME
>> +	/*
>> +	 * PM_RUNTIME is mostly transparent. However to do it right we need to a
>
>need to _do_ a ...?
I think dropping that 'to' should fix it.

>> +	 * TX empty interrupt before we can put the device to auto idle. So if
>> +	 * PM_RUNTIME is not enabled we don't add that flag and can spare that
>> +	 * one extra interrupt in the TX path.
>> +	 */
>
><snip>
>
>> +config SERIAL_8250_OMAP
>> +	tristate "Support for OMAP internal UART (8250 based driver)"
>> +	depends on SERIAL_8250 && ARCH_OMAP2PLUS
>> +	help
>> +	  If you have a machine based on an Texas Instruments OMAP CPU you
>> +	  can enable its onboard serial ports by enabling this option.
>> +
>> +	  This driver is in early stage and uses ttyS instead of ttyO.
>> +
>
>I just wondered if this driver should be marked experimental?
What did you have in mind? CONFIG_EXPERIMENTAL is gone. After all that
debuging that I had in the meantime I was thinking about dropping that
"early stage".

>Thanks,
>Frans

Sebastian
