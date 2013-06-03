From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] serial: omap: repair building without PM_SLEEP
Date: Mon, 03 Jun 2013 11:50:09 -0700
Message-ID: <871u8jm3ku.fsf@linaro.org>
References: <1844339.mxci2DdvBF@wuerfel> <20130603170730.GA30767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130603170730.GA30767@kroah.com> (Greg Kroah-Hartman's message
	of "Mon, 3 Jun 2013 10:07:30 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Sat, Jun 01, 2013 at 11:18:13AM +0200, Arnd Bergmann wrote:
>> A recent bug fix in 3.10, ddd85e225c "serial: omap: prevent runtime PM for
>> "no_console_suspend"", introduced a regression from an obvious typo:
>
> I don't see that commit id, or commit, in Linus's tree at all.  Where do
> you see it?

It's in linux-next (from your tty-next branch.)

>> drivers/tty/serial/omap-serial.c:1677:14: error: 'serial_omap_complete' 
>> 	undeclared here (not in a function)
>> 
>> This changes the incorrectly added macro to the one that we need instead.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kevin Hilman <khilman@linaro.org>

>> ---
>> Please apply for 3.10-rc
>
> Really?  It doesn't apply to 3.10-rc3 or -rc4 from what I can tell.

Right, this is -next material, not v3.10.

Kevin
