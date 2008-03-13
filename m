From: "Tim Chen" <tim.chen.86@gmail.com>
Subject: Re: MTD partitions
Date: Thu, 13 Mar 2008 18:24:18 +0800
Message-ID: <9c1eb1b90803130324o67b00e06k83679f1dc2259e8d@mail.gmail.com>
References: <9c1eb1b90803120306u52ed28cdr4039cd772e901b3@mail.gmail.com>
	 <200803120316.56363.david-b@pacbell.net>
	 <9c1eb1b90803122032j2d1c83adk175e4ade0bf2fcab@mail.gmail.com>
	 <200803122119.46453.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:3250 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYCMKYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 06:24:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2044257rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 13 Mar 2008 03:24:18 -0700 (PDT)
In-Reply-To: <200803122119.46453.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

Hi David,
Solved,
Finally, I checked out a new GIT tree, the previous I used is
linux-2.6.23-rc3-omap1(might be quite old).
As you said, I modified the board-(MYBOARD).c file.

Also, The NAND flash part is  the Samsung K5E1212ACB MCP(64MB NAND
flash/64MB DDR), as the IDs shown below,

NAND device: Manufacturer ID: 0xec, Chip ID: 0x36 (Samsung NAND 64MiB 1,8V 8-bit
)
Scanning device for bad blocks
Bad eraseblock 753 at 0x00bc4000
Bad eraseblock 1007 at 0x00fbc000
Bad eraseblock 1112 at 0x01160000
Bad eraseblock 1281 at 0x01404000
Bad eraseblock 1948 at 0x01e70000
Bad eraseblock 2158 at 0x021b8000
Bad eraseblock 2328 at 0x02460000
Bad eraseblock 2941 at 0x02df4000
Creating 5 MTD partitions on "omapnand.0":
0x00000000-0x00010000 : "xloader"
mtd: Giving out device 0 to xloader
0x00010000-0x00050000 : "bootloader"
mtd: Giving out device 1 to bootloader
0x00050000-0x00080000 : "params"
mtd: Giving out device 2 to params
0x00080000-0x00280000 : "kernel"
mtd: Giving out device 3 to kernel
0x00280000-0x04000000 : "filesystem"
mtd: Giving out device 4 to filesystem


On Thu, Mar 13, 2008 at 12:19 PM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 12 March 2008, you wrote:
>  > I added the MTD partition information to board-($MYBOARD).c,
>  > But kernel didn't show any MTD partition information during booting.
>
>  That means you didn't connect something correctly.  Is the right
>  platform device present?  Is its driver loaded?  Is it successfully
>  probing?  Did you enable partitions?  You can enable MTD debug to
>  see most of that.
>
>
>
>  > If I have to create the MTD partitions using MTD commands in u-boot first?
>  > My u-boot is old, no MTD support, if that's the case, I'll port the newer
>  > u-boot, then try again.
>
>  That would only matter if you're trying to boot from e.g. a JFFS2
>  partition using u-boot.  Or, depending on what you mean, load the
>  kernel from flash.
>
>  What you need to do first is make sure that the kernel sees the
>  flash chip, and then make sure the partition info is used.
>
>
>
>



-- 
--
Regards,
Tim.
