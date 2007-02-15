From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: [PATCH 0/4] OMAP2 Camera driver
Date: Thu, 15 Feb 2007 16:56:00 +0530
Message-ID: <5d5443650702150326k58c6c611s7f19eab8a35166bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

These series of patches contain the OMAP2 camera driver and the
related changes into the sensor interface.

- It removes lots of whitespaces
- Taken code from N800 camera driver changes and Komal Shah's patches.
- There are still few changes I need to derive from N800 camera
driver, but it will be done in incremental fashion including the
tcm825x sensor driver.
- sensor interface is changed to accomodate Micron camera sensor
driver in OMAP2430.

I would suggest to push these patches, so that other planned changes
can also be done as this driver is pending from very long time.

-- 
--Trilok Soni
