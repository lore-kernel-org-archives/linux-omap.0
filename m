From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] ARM: OMAP: Use I2C bus registration helper
Date: Fri, 2 Nov 2007 09:27:40 -0700
Message-ID: <200711020927.40350.david-b@pacbell.net>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
	<1194011191-29395-3-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1194011191-29395-3-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 02 November 2007, jarkko.nikula@nokia.com wrote:
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -477,6 +477,7 @@ static void __init osk_init(void)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
ARRAY_SIZE(osk_i2c_board_info));
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0omap_serial_init();
> +=A0=A0=A0=A0=A0=A0=A0omap_register_i2c_bus(1, 100);

I always use 400 kHz on this board.  :)

Is there a reason you're not using 400k anywhere?
ISTR at one point checking specs and finding that
many TI dev boards were spec'd so that 400k should
work fine.

> =A0=A0=A0=A0=A0=A0=A0=A0osk_mistral_init();
> =A0}
>=20
