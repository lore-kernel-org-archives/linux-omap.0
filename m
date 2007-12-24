From: "Raghunandan Dhongadi" <dk.raghu@gmail.com>
Subject: OMAP2430 I2C Controller
Date: Mon, 24 Dec 2007 09:37:09 +0530
Message-ID: <7d8fdf6f0712232007w64624e3aoa7523c8cabf8fe9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

I am facing an issue with setting up the i2c-omap controllers on the
Linux 2.6.22 kernel. All though the I2C platform registration happens
in the board file, and
the "driver/i2c/bussess/i2c-omap.c" has the "i2c_probe" function that
sets of the Interface and Functional clock, when I do a register dump
of the clock registers,
The Functional clock of I2C controllers are not enabled.

clues anyone?
Thanks in Advance,
Raghu
