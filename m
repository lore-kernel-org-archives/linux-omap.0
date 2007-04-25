From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: is there any tool for burning omap730 image under linux?
Date: Wed, 25 Apr 2007 10:49:11 -0500
Message-ID: <462F7877.3050305@css-design.us>
References: <OF9C83F916.25673C7B-ON482572C8.000EADD1-482572C8.000D3CF6@konka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <OF9C83F916.25673C7B-ON482572C8.000EADD1-482572C8.000D3CF6@konka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: jiangqingdong@konka.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Since you ask how to burn under linux, I assume you already have a 
flashed u-boot and are able to boot Linux. 

Make sure you have MTD support in your kernel.  If configured properly, 
you should be able to simply copy a binary image to the proper device 
file.  One issue in doing this comes up if you flash supports protected 
sectors.  You will get errors about trying to write to protected flash.  
I wrote a simple application using mtd ioctl's to unprotect, program, 
then protect.  Before you can even use such an application, you need to 
get the /dev/mtd* files created and working.  Check the /proc folder.  I 
recall there is a /proc/mtd (or something like that) if MTD is in your 
kernel.  It shows you how your flash is divided.  NOTE, I may remember 
it wrong and it is not /proc but actually a sysfs file.  Another 
solution may be to unprotect using u-boot, boot the kernel, then copy to 
the proper /dev/mtd* file.  I would avoid /dev/mtd0 and /dev/mtd1 until 
you are confident in the procedure.   These are typically u-boot and 
u-boot config.   /dev/mtd2 should be the kernel part of the flash and 
/dev/mtd3 is the flashed file system.  Another thing to consider is that 
you could have MTD configured different than u-boot expects and 
everything will still work....until you go to copy using /dev/mtd* that 
is *watch out*.

If your question is more basic than this, I suggest the OSK newbie 
guide.  That will get your application programmed outside of Linux.  To 
program the first u-boot, I like to use the toolchain to make a u-boot 
that can be loaded by the emulator through CCS. 

Steve

jiangqingdong@konka.com wrote:
> is there any tool for burning omap730 image under linux?
>
> thanks
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>   
