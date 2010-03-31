From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH-V2] OMAP: Fix for bus width which improves SD card's
 peformance.
Date: Wed, 31 Mar 2010 16:11:53 +0300
Message-ID: <20100331161153.73d687ee.jhnikula@gmail.com>
References: <35697.192.168.10.89.1265898023.squirrel@dbdmail.itg.ti.com>
	<004701caab40$68b576e0$544ff780@am.dhcp.ti.com>
	<x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com>
	<v2yce9ab5791003302327hc67deb3akc7d18146534038f9@mail.gmail.com>
	<h2p7f9d1ffb1003310003z508e21dbqe37b6e1cad425866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <h2p7f9d1ffb1003310003z508e21dbqe37b6e1cad425866@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishore kadiyala <kishorek.kadiyala@gmail.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, Madhusudhan <madhu.cr@ti.com>, tony@atomide.com, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.lavinen@nokia.com
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Mar 2010 12:33:01 +0530
kishore kadiyala <kishorek.kadiyala@gmail.com> wrote:

> This patch improves low speeds for SD cards.
> OMAP-MMC controller's can support maximum bus width of '8'.
> when bus width is mentioned as "8" in controller data,the SD
> stack will check whether bus width is "4" and if not it will
> set bus width to "1" and there by degrading performance.
> This patch fixes the issue and improves the performance of
> SD cards.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> ---
> In V2 : Appended Signed-off by Venkat and Ack by Madhu
> 
>  Here are my experiment numbers, on a Class 6 SDHC card:
>  Read peformance is increased by 220%
>  Write Performance is increased by 52%
> 
Some results from the BeagleBoard and 2 GB SD card:

sync; time (dd if=/dev/zero of=`date +%s`.bin bs=1M count=100; sync)
-> ~40 % improvement over 4 writes.

time dd if=12700xxxxx.bin of=/dev/null
-> ~96 % improvement over 4 reads.

Feel free to add my tested-by.

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
