From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: Regarding MMC/SD issues on 2430 SDP.
Date: Tue, 24 Jul 2007 19:35:34 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470163AF5F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi:

As I see many of us are facing some kind of issues with MMC/SD on 2430 =
SDP, I thought of passing my findings to all.

On 2430 SDP 1.0 with 2430 ES 1.0
	Slot-1 works for: MMC (1.8v/3v), SD, SDIO cards
	Slot-2 works for: MMC (1.8v) (only 1.8v cards)

On 2430 SDP 2.0 with 2430 ES 2.0
	Slot-1 works for: MMC (1.8v only), "Doesn't work for 3v cards =
(MMC/SD/SDIO)"
	Slot-2 works for: MMC (1.8v) (only 1.8v cards) doesn't work

On 2430 SDP 4.0 with 2430 ES 2.1
	Slot-1 works for: MMC (1.8v/3v), SD, SDIO cards
	Slot-2 works for: Doesn't work

On 2430 SDP 5.0 with 2430 ES 2.1
	Slot-1 works for: MMC (1.8v/3v), SD, SDIO cards
	Slot-2 works for: Doesn't work

Board revision can be located on MMC Slot of any 2430 SDPs.

Silicon revision can be found from u-boot boot messages or by reading =
IDCODE register.

Example:
=3D=3D=3D=3D=3D=3D=3D=3D
OMAP2430C-GP revision 3, PRCM #2
TI 2430SDP 0.1 Version + mDDR (Boot NOR)
DRAM:  128 MB
Flash: 192 MB
In:    serial
Out:   serial
Err:   serial
OMAP243X SDP #

>From first line:
Revision 1 =3D ES1
Revision 2 =3D ES2
Revision 3 =3D ES2.1

Key Note:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
- 3v cards doesn't work on 2430 ES 2.0 boards. So, if MMC/SD/SDIO card =
is failing on your board then this might be one of the reasons.
- MMC Slot2 cannot be used as it's modified to support other =
requirement.

Regards,
Khasim
