From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Add OMAP high-speed UART driver.
Date: Mon, 1 Mar 2010 18:13:01 +0000
Message-ID: <20100301181301.08d67b03@lxorguk.ukuu.org.uk>
References: <41322.192.168.10.89.1267454612.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41322.192.168.10.89.1267454612.squirrel@dbdmail.itg.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-omap@vger.kernel.org

> +		 213 = /dev/ttyO0		OMAP serial port 0
> +		 214 = /dev/ttyO1		OMAP serial port 1
> +		 215 = /dev/ttyO2		OMAP serial port 2
> +		 216 = /dev/ttyO3		OMAP serial port 3

I think it might be best to allocate a dynamic tty major nowdays

Other problem is that I don't see where you hold the port lock over all
uses of port->tty. That is an assumption of the serial layer and done in
the original 8250 driver correctly.

Rest looks good and I agree that OMAP is different enough from 8250 that
it makes sense not to further clutter the 8250 driver.
