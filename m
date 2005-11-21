From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: Kernel not working
Date: Mon, 21 Nov 2005 15:51:03 -0000
Message-ID: <007f01c5eeb3$60c99ef0$642aa8c0@BUFFY>
References: <20051121143139.83027.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051121143139.83027.qmail@web32905.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Komal Shah' <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com, 'Vineet Tuli' <vineet@cybernetra.com>
List-Id: linux-omap@vger.kernel.org

Hello again,

Please accept my apologies if I seem a little slow. I downloaded the
pre-built 3.4.2 toolchain and it has the bug mentioned in the newbie guide
so that Uboot 1.1.3 does not build. Since, I do not have the source to the
3.4.2 toolchain it is impossible for me to apply the patch recommended by
the documentation to elf32-arm.h ;-(

Can somebody point me at a pre built arm-linux tool chain so I can build
Uboot 1.1.3 please? Or a pre-built Uboot.bin 1.1.3 for OMAP 5912OSK?

Many thanks,

Richard.



-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com] 
Sent: 21 November 2005 14:32
To: Richard Copeman; linux-omap-open-source@linux.omap.com; 'Vineet Tuli'
Subject: RE: Kernel not working

--- Richard Copeman <richard.copeman@lauterbach.co.uk> wrote:

> Hi,
> 
> Many thanks for the pointers. I have taken a look at the newbie
> guide. I
> have got a 2.6.13.4 kernel built with gcc 3.4.1 as per the
> instructions in
> the guide. I have the kernel image tftpboot loaded onto my OSK board
> and
> things progress a little further (but not much).
> 
> I get:
> 
> Starting kernel ...
> 
> Uncompressing
> Linux......................................................
> 
> And then it all stops. In the newbie guide there was a section about
> this
> and I have added the extra head-omap.o to my Makefile in
> arch/arm/boot/compressed and rebuilt but still no improvement.
> Grepping
> through the build logs the object has been included so I'm guessing
> my mods
> worked ;-)
> 
> On another point, my board does not allow me to save my Uboot
> environment.
> Typing save gives me:
> 
> Saving E"@ironment to Flash...
> Un-Protected 1 sectors
> Erasing Flash...Can't erase unknown flash type 00000000 - aborted
> Erased 1 sectors
> Error: start and/or end address not on sector boundary
> OMAP5912OSK#

As I am not a OSK user, but I remember someone saying that updating the
u-boot helps on OSK. Please try the latest version of u-boot then.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
