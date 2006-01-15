From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Sun, 15 Jan 2006 18:14:26 +0100
Message-ID: <fb249edb0601150914o1fb58c6fs@mail.gmail.com>
References: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
	<20060115091040.80061.qmail@web32906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060115091040.80061.qmail@web32906.mail.mud.yahoo.com>
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
To: linux-omap-open-source@linux.omap.com, Komal Shah <komal_shah802003@yahoo.com>
List-Id: linux-omap@vger.kernel.org

Hi,
thanks for looking at the patches,

> e.g Integrating OMAP2430 and DM6446/DM6443 McBSP interface and imagine
> how this mcbsp.c will look like :)
>
Right, that would make it a big mess and kindof hard to maintain.
Additionaly, I think the OMAP 730 definitions have been left out of
the conditional part and will produce compilation errors.

> See as of know all audio codec + tsc controller drivers are specific to
> OMAP, but can be used with other chips, and generally interfaced by
> uWire (SPI half-duplex) or SPI or I2C for command interface to the
> chip. So recently we had SPI framework developed by David Brownell,
> Dmitry, Vitally wool which will make its way in 2.6.16, considering
> there is no objections.
>
> You may want to experiment more with it. David had uWire hacks to merge
> with its SPI subsytem, which I will forward to you. Here is the link of
> that subsystem as GIT tree.
>
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/gregkh/spi-2.6.git;a=3Dsu=
mmary
>
Thanks for the link. Unfortunately I only have this one PDA that
contains the TSC2301 chip, and it uses only uWire to communicate with
it. And.. I'm currently at the point of trying to mount some initrd as
root and having somethng for input (like the touchscreen) so I didn't
have space for experimenting with things like audio so far. But I
think both the TSC2301 and the Touchscreen code can be reused.

> > - The last patch only corrects some typos I found
> > while browsing the sources.
>
> These are generic ARM typos changes, and it should be submitted to
> linux-arm-kernel mailing list. But see that our tree is not synced with
> linus tree as of now. So, it is better to generate those typos patches
> against linus tree (if generic) than OMAP tree.
>
Okay, already sent it. It applied cleanly to Linus tree without rediff'ing.

> --- linux-omap-2.6.orig/drivers/input/touchscreen/omap/omap_ts.c
> 2006-01-14 14:59:17.000000000 +0000
> +++ linux-omap-2.6/drivers/input/touchscreen/omap/omap_ts.c     2006-01-1=
4
> 15:56:12.000000000 +0000
> @@ -23,7 +23,7 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> USA
>   * History:
>   * 12/12/2004    Srinath Modified and intergrated code for H2 and H3
> - *
> + * 13/01/2006    Added PalmTE specific code, Andrzej Zaborowski
>   */
>
> I would suggest to not add up History changes as above, as AUTHOR name
> will be there when Tony commits in the tree, until we have create a new
> file (eg. plamte_ts.c).
>
Good point. In the end the revision system (GIT) is there to keep the histo=
ry.

I am attaching a corrected version of the Touchscreen support patch
(the second one).

Regards,
Andrzej Zaborowski
--
balrog 2oo6

Dear Outlook users: Please remove me from your address books
http://www.newsforge.com/article.pl?sid=3D03/08/21/143258
