From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: multiple board files (was Re: [PATCH] OMAP: 2430SDP: Support LCD
	display as a FB device)
Date: Fri, 25 May 2007 18:01:59 -0500
Message-ID: <782515bb0705251601h7fe84dcbod53d74d46bdef28a@mail.gmail.com>
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
To: Kevin Hilman <khilman@mvista.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kevin,

On 5/25/07, Kevin Hilman <khilman@mvista.com> wrote:
> Hmm, the display changes were indeed added to board-2430.c, not to anthoer new file.
>
> Personally, I think the multiple board files are easier to read, and cleaner.  Did you notice all the board-n800* files?

yup, it was a hasty mail.. couple of thoughts:
a) linux-omap-2.6/drivers/video/omap/lcd_2430sdp.c seems to contain
stuff which are very board specific which can easily go along with the
rest of the stuff in board-2430sdp.c
b) on the readability argument.. well.. it is a matter of perception i
guess.. arch/arm/mach-omap2/board-2430sdp.c
arch/arm/mach-omap2/board-2430sdp-flash.c contain flash definitions..
one for the L18 NOR and the other for the onenand.. kinda not
readable..let me look at standard method:
to get a stat:
 for i in arch/arm/mach-*; do K=`find $i -iname "board*"|wc -l`; if [
$K -ne 0 ]; then echo $i $K; fi; done
arch/arm/mach-at91 14
arch/arm/mach-davinci 1
arch/arm/mach-ks8695 1
arch/arm/mach-ns9xxx 4
arch/arm/mach-omap1 14
arch/arm/mach-omap2 15
of our mach omap2:
n800: 8 files
2430: 3 files
apollon: 2 files
Our mach-omap2 directory has 15 board files for 3 boards? Imagine
having 10 different boards on omap2.. and each with multiple board
files.. most of which cannot be reused... I am foreseeing
non-readability there. IMHO having multiple files is not a scalable
solution in the long run.. mebbe organising the board file to be
readable makes sense..

Regards,
Nishanth Menon
