From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Getting boot prompt with Minicom
Date: Mon, 7 May 2007 10:54:38 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47D5EADC@dlee13.ent.ti.com>
References: <463F494A.8030702@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <463F494A.8030702@trolltech.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Boosalis <david.boosalis@trolltech.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>I fired up my demo board, which is a SDP2430.  I  also have  connected
>my PC to the board via a serial cable attached to Port 1 (J9) .  I have
>set my Minicom settings to 115200 8 N 1, but am unable to get any =
prompt
>of any type.

If you are using u-boot as bootloder then your UART cable should be =
connected to J8 (UART 1 2). Next to the Ethernet switch.

>Are  these minicom settings correct ?
Minicom settings looks correct.

Regards,
Khasim
