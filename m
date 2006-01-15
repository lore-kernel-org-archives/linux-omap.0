From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Sun, 15 Jan 2006 01:10:40 -0800 (PST)
Message-ID: <20060115091040.80061.qmail@web32906.mail.mud.yahoo.com>
References: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- andrzej zaborowski <balrogg@gmail.com> wrote:

> 
> - The first one fixes the compilation errors and
> some clock issues
> that made the kernel hang on boot on Palm Tungsten
> E. While these
> changes make the kernel boot and work well with the
> device, and

Tony can comment on this clock changes for 15xx.

> Note that the last hunk is for a compilation error
> introduced two days
> ago here:
>
http://www.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=89ac1ab633637032c80a5d3424120d153ff7d754
> and I think today someone already proposed a
> different idea for
> dealing with this error.

Yes, as I don't like #ifdefers. Your fix is good, but for future as
more and more silicons will be popped out from TI and McBSP reamins
their standard choice for Audio Codec chip interface, it is better work
on small/thin framework which can take platform specific data, and let
audio codec chip also know from their platform specific data about
McBSP configuration.

e.g Integrating OMAP2430 and DM6446/DM6443 McBSP interface and imagine
how this mcbsp.c will look like :)

> 
> - The second patch adds support for the Touchscreen
> device found in
> OMAP310. Again I don't know how proper is the
> driver, but it works and
> it was written according to the documentation from
> Texas Instruments.
> Because the DSP chipset of the OMAP310 board (called
> TSC2301) carries
> out a big part of the task of controlling the
> touchscreen, in
> hardware, the driver mechanism for this touchscreen
> is much simpler
> than other OMAP touchscreens and I had to make small
> changes in
> "omap_ts.c" which is generic for all OMAP
> touchscreens.

TSC2301 support is really good, there was no community known driver
available yet. Even this chip has audio + 2 gpios + keyboard controller
which you may want to experiment with now.

See as of know all audio codec + tsc controller drivers are specific to
OMAP, but can be used with other chips, and generally interfaced by
uWire (SPI half-duplex) or SPI or I2C for command interface to the
chip. So recently we had SPI framework developed by David Brownell,
Dmitry, Vitally wool which will make its way in 2.6.16, considering
there is no objections. 

You may want to experiment more with it. David had uWire hacks to merge
with its SPI subsytem, which I will forward to you. Here is the link of
that subsystem as GIT tree.

http://www.kernel.org/git/?p=linux/kernel/git/gregkh/spi-2.6.git;a=summary

> 
> - The last patch only corrects some typos I found
> while browsing the sources.

These are generic ARM typos changes, and it should be submitted to
linux-arm-kernel mailing list. But see that our tree is not synced with
linus tree as of now. So, it is better to generate those typos patches
against linus tree (if generic) than OMAP tree.

> 
> I think the second and the third patch are 100% safe
> to apply, and the

--- linux-omap-2.6.orig/drivers/input/touchscreen/omap/omap_ts.c
2006-01-14 14:59:17.000000000 +0000
+++ linux-omap-2.6/drivers/input/touchscreen/omap/omap_ts.c	2006-01-14
15:56:12.000000000 +0000
@@ -23,7 +23,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA
  * History:
  * 12/12/2004    Srinath Modified and intergrated code for H2 and H3
- *
+ * 13/01/2006    Added PalmTE specific code, Andrzej Zaborowski
  */
 
I would suggest to not add up History changes as above, as AUTHOR name
will be there when Tony commits in the tree, until we have create a new
file (eg. plamte_ts.c).

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
