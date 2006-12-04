From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: OMAP I2C - probe question
Date: Mon, 4 Dec 2006 13:46:51 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4702AEA6@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

Do we have a method of doing an I2C probe for OMAP I2C devices? I found
i2c_probe failing in Menelaus driver for H4-2420.=20

"i2c_adapter i2c-0: SMBus Quick command not supported, can't probe for
chips"

I was looking at one of the mail discussion from David B.

http://lists.lm-sensors.org/pipermail/i2c/2006-October/000298.html

I didn't see any conclusion though. Actually I don't want to do an I2C
probe, I know I2C adapter for my board. But in order to write a generic
I2C chip driver it might be required to probe for the device (as there
are multiple adapters on OMAP2430 / 3430).=20

Can I follow the way (using force) presented by David B in his patch?=20

Thanks & Regards,
Khasim
