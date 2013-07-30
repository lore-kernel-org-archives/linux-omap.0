From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: Linux kernel for OMAP5432 uEVM
Date: Tue, 30 Jul 2013 09:22:27 +0530
Message-ID: <51F7387B.9060304@ti.com>
References: <20130730033808.GA23486@cbz-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50568 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918Ab3G3Dwb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 23:52:31 -0400
In-Reply-To: <20130730033808.GA23486@cbz-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Baozi <baozich@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Chen,
On Tuesday 30 July 2013 09:08 AM, Chen Baozi wrote:
> Hi all,
> 
> I'm trying to boot my OMAP5432 uEVM devboard with the lastest kernel of
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git.
Which branch are you using ?
> However, after u-boot loading uImage & DTB, there is no output message any
> more, such as:
Clk data might be missing here. Try merging the below branch and test it
https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux.git/log/?h=for_3.11/out_of_tree/omap5_clk_data

You can also use Linus's kernel with the above clk data branch.( OMAP5 uEVM boots)
Please let me know if you need more info.

Thanks and regards,
Lokesh

> 
> ## Executing script at 82000000
> reading omap5-evm-omap.dtb
> 15280 bytes read in 6 ms (2.4 MiB/s)
> reading uImage-omap
> 3996552 bytes read in 250 ms (15.2 MiB/s)
> ## Booting kernel from Legacy Image at 80300000 ...
>    Image Name:   Linux-3.10.0-rc6-12306-g0dbc346
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3996488 Bytes = 3.8 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 825f0000
>    Booting using the fdt blob at 0x825f0000
>    Loading Kernel Image ... OK
> OK
>    reserving fdt memory region: addr=9d000000 size=3000000
>    Loading Device Tree to 83ff9000, end 83fffbaf ... OK
> 
> Starting kernel ...
> 
> Before trying this tree, I'm using the 3.8.4 kernel from TI. And it does
> support the board and can successfully boot.
> 
> Anything that I may have missed when configuring the kernel? I use
> omap2plus_defconfig and add DEBUG_LL, DEBUG_OMAP2PLUS_UART,
> DEBUG_OMAP4UART3... 
> 
> Cheers,
> 
> Chen Baozi 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

