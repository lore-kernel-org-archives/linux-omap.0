From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: Add omapserial earlycon
Date: Fri, 20 Jan 2017 10:32:35 -0800
Message-ID: <20170120183235.GG7403@atomide.com>
References: <20170119095938.30976-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119095938.30976-1-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [170119 02:02]:
> Add DT earlycon for omap_serial driver. This boot console is included
> with CONFIG_SERIAL_EARLYCON=y, CONFIG_OF=y, CONFIG_SERIAL_OMAP=y, and
> CONFIG_OF_EARLY_FLATTREE=y.
> 
> This boot console is enabled with the command line option "earlycon"
> (without "=<name>...") when the DT 'stdout-path' property matches a
> compatible uart.

Acked-by: Tony Lindgren <tony@atomide.com>
