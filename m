From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: Kernel not working
Date: Mon, 21 Nov 2005 06:31:38 -0800 (PST)
Message-ID: <20051121143139.83027.qmail@web32905.mail.mud.yahoo.com>
References: <006301c5eea7$6619c080$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <006301c5eea7$6619c080$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com, 'Vineet Tuli' <vineet@cybernetra.com>
List-Id: linux-omap@vger.kernel.org

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
