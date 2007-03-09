From: Imre Deak <imre.deak@solidboot.com>
Subject: TSC2101/2102
Date: Fri, 9 Mar 2007 16:06:51 +0200
Message-ID: <20070309140650.GC4399@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: balrog@zabor.org, Nishanth Menon <x0nishan@ti.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I'm wondering about the proper way to convert the existing omap-tsc2101
driver to the SPI framework. Would it make sense to handle it with the
tsc2102 driver? omap-tsc2101 has only the register read / write interface
which is the same as in tsc2102.

Are you planning to do this? I'd need to access the tsc2101 from another
driver.

--Imre
