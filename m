From: "G Kondaiah, Manjunath" <xgkondai@ti.com>
Subject: RE: OMAP1 IrDA driver doubts
Date: Wed, 14 Dec 2005 07:18:33 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50365E8B6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


B)
>>>--------snip-------------
>>>omap_irda_startup(...)
>>>...
>>>/* Enable UART3 clock and set UART3 to IrDA mode */
>>>omap_writel(omap_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
>>>            MOD_CONF_CTRL_0);
>>>--------snip-------------
>>>As comment suggests that it is enabling UART3 clock, why don't we use
>>>clk_use(...) api? And setting irda_mode from omap_irda_config
function like in >>>usb->hmc_mode?

For H3 - Only bit 31 is valid for enabling UART clock. Setting bit 15
has no effect.  You can remove this and use clock api's.  I am not sure
about H2.=20

drivers/net/irda/omap-ir.c -

it is better if UART defines are moved to arch specific header file

include/asm-arm/arch-omap/irda.h  - copyright header is missing.

Regards,
Manjunath

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Wednesday, December 14, 2005 6:08 AM
To: G Kondaiah, Manjunath; linux-omap-open-source@linux.omap.com
Subject: RE: OMAP1 IrDA driver doubts

--- "G Kondaiah, Manjunath" <xgkondai@ti.com> wrote:

> Hi Komal,
>=20
> A) is required since the same lines are shared between IrDA and aGPS
> modules. There is an I/O Expander to select these lines on H3/H4
> using
> I2C.

Thanx. I have taken it as set_power function for a while in the recent
patch posted on the list for 24xx irda support, but I will try to
rename it something different in the next patch.

Could you please comment on the B) and C) also? _or_ It would be gr8,
if you give me some patch review comments :)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
