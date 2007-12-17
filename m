From: "Reddy, Teerth" <teerth@ti.com>
Subject: Watchdog driver issue on OMAP3
Date: Mon, 17 Dec 2007 06:24:17 -0600
Message-ID: <465714FA584D6D49BD2ADB26BB64FD0D01B9A8AB@dlee13.ent.ti.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



Hi

I am seeing this issue with the watchdog driver on OMAP3430,whenever the =
watchdog driver is closed the board should reboot but the board freezes =
after the watchdog timeout and I have to reboot the board manually to =
get the u-boot back.

	Is this an issue with the watchdog driver or is something else causing =
this?=20

Best Regards,
Teerth
