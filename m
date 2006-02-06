From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: SDRAM clock changes ?
Date: Mon, 6 Feb 2006 09:29:38 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF403772020@dlee02.ent.ti.com>
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
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Ram,

>    I want to change the sdram setting from 96 MHZ to 192MHZ in OMAP.
>=20


What OMAP device are you using? If it is the OMAP5912, then the maximum
speed we support for SDRAM on the OMAP5912 is 96MHz. You could
theoretically change the DPLL settings to operate the interface at
192MHz, however, our specification only permits you to run the interface
at 96MHz.=20

Regards,
Jon
