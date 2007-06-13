From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: What is the correct approach for common board devices...?
Date: Tue, 12 Jun 2007 23:01:12 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E5951@dlee13.ent.ti.com>
References: <20070612181652.GS28834@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070612181652.GS28834@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

There are some devices like TS, Keypad, I2C, Flash, etc that are almost =
common between 2430 and 3430 SDPs.=20

Today in tree we have files like board-2430sdp-flash.c which can be =
reused for 3430 too.

The board-2430sdp.c has Keymap that holds good for 3430 too.

Can you please suggest the correct way to organize these kind of devices =
in mach-omap2 directory?

Regards,
Khasim
