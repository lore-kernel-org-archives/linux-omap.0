From: "arun c" <arun.edarath@gmail.com>
Subject: U-boot at 0x10000
Date: Thu, 28 Jun 2007 12:50:22 +0530
Message-ID: <c656a4d20706280020y6bc7ae4cwc0cb673572b28a86@mail.gmail.com>
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

Hi all,


Thank you very much Sriram.

>From the answer i understand,

1) While flashing, Nand is addressed at 0x0c000000
thats why we write xload.bin.ift there

2) While booting from nand flash it is addressed(CS0) at 0x0
Thats why we flash u-boot at 0x10000(0+4*16k=0x10000)


Is this correct?

Thanks&warm regards
Arun c
