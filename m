From: "Veda N" <veda74@gmail.com>
Subject: clock trees
Date: Fri, 20 Jul 2007 17:25:00 +0530
Message-ID: <a5eaedfa0707200455k21535ba9l5f3aa2dc8aa0c959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
    OMAP 2430 supports 5 clock frequencies 12 MHZ, 13 MHZ, 19.2-MHz, 24MHZ,
26MHZ

    There is a rate_table clock.h/clock.c in linux kernel which has support
for 13MHZ.

    If the crystal frequency is 12/19.2 MHZ. What changes do we need to make

    in the linux kernel to support the new frequencies.

    Does kernel really need these clock tables as they are set in the
bootloader.

    Does the kernel change the values of clocks set in the bootloader.


Regards,
vedan
