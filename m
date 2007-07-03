From: "arun c" <arun.edarath@gmail.com>
Subject: What is NAND sector size?
Date: Tue, 3 Jul 2007 12:36:49 +0530
Message-ID: <c656a4d20707030006u71af1aaej1eac87122d195f67@mail.gmail.com>
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

HI,

I am porting uboot to a new omap board.

My nand details are given below
page size=2111(2047+64)
block size=64 pages
total size=2047 blocks

while going through the uboot configurations i met this NAND settings.
#define    SECTORSIZE                  512
#define CFG_MAX_FLASH_SECT   (259)


Is this sector size=pagesize?
In my case do i need to change this to 2048?

And what is CFG_MAX_FLASH_SECT for my nand device?

Regards
Arun
