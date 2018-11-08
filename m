From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix possible use of uninitialized
 field
Date: Thu, 8 Nov 2018 09:25:58 -0800
Message-ID: <20181108172558.GO56134@atomide.com>
References: <20181107213031.21650-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107213031.21650-1-jmkrzyszt@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [181107 13:28]:
> While playing with initialization order of modem device, it has been
> discovered that under some circumstances (early console init, I
> believe) its .pm() callback may be called before the
> uart_port->private_data pointer is initialized from
> plat_serial8250_port->private_data, resulting in NULL pointer
> dereference.  Fix it by checking for uninitialized pointer before using
> it in modem_pm().

Applying into omap-for-v4.20/fixes thanks.

Tony
