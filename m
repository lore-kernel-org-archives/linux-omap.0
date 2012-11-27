From: "Thomas Weber" <thomas@tomweber.eu>
Subject: Re: [PATCHv2] OMAP: board-files: fix i2c_bus for tfp410
Date: Tue, 27 Nov 2012 11:02:52 +0100
Message-ID: <f129a4f7c8bff131477f395d2ba4b2c2.squirrel@tomweber.eu>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
    <1353573596-5550-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1353573596-5550-1-git-send-email-tomi.valkeinen@ti.com>
Sender: stable-owner@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Weber <thomas@tomweber.eu>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Tomi,

> The i2c handling in tfp410 driver, which handles converting parallel RGB
> to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af
> (OMAPDSS: TFP410: pdata rewrite). The patch changed what value the
> driver considers as invalid/undefined.  Before the patch, 0 was the
> invalid value, but as 0 is a valid bus number, the patch changed this to
> -1.
>
> However, the fact was missed that many board files do not define the bus
> number at all, thus it's left to 0. This causes the driver to fail to
> get the i2c bus, exiting from the driver's probe with an error, meaning
> that the DVI output does not work for those boards.
>
> This patch fixes the issue by changing the i2c_bus number field in the
> driver's platform data from u16 to int, and setting the bus number to -1
> in the board files for the boards that did not define the bus. The
> exception is devkit8000, for which the bus is set to 1, which is the
> correct bus for that board.
>
> The bug exists in v3.5+ kernels.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Thomas Weber <thomas@tomweber.eu>
> Cc: Thomas Weber <thomas@tomweber.eu>
> Cc: <stable@vger.kernel.org> # v3.5+

I have tested the patch on Devkit8000.
Tested-by: Thomas Weber <thomas@tomweber.eu>

Thanks.

Thomas
