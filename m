From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: new PRCM breakage: 2430 FB
Date: Mon, 11 Jun 2007 23:25:41 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470117CC01@dlee13.ent.ti.com>
References: <Pine.LNX.4.64.0706111821110.28778@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0706111821110.28778@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>Could be a TWL4030 problem given the lack of power.

Actually the LDO enabling logic should not be part of LCD, the UI Board =
peripherals TouchScreen, LCD, IrDA~ depends on this.=20

This functionality should be moved to board dependent files and should =
be independently called from respective drivers (all), the usage count =
should control the enable/disable part.

With existing logic Touchsceen will not work if LCD is disabled.

Kevin, do you want me to modify this part?=20

Regards,
Khasim
