From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: u-boot delay on OMAP2430 SDP
Date: Sun, 21 Jan 2007 13:52:24 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5096FA751@dlee02.ent.ti.com>
References: <c04186510701210607w769944apb47cb0c576cb2431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <u-boot-users-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <c04186510701210607w769944apb47cb0c576cb2431@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=u-boot-users>
List-Post: <mailto:u-boot-users@lists.sourceforge.net>
List-Help: <mailto:u-boot-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=subscribe>
Sender: u-boot-users-bounces@lists.sourceforge.net
Errors-To: u-boot-users-bounces@lists.sourceforge.net
To: sandeep prabhu <sandeep.mitian@gmail.com>, Linux-omap-open-source@linux.omap.com, u-boot-users@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

> I am using the "u-boot_16.3.tar.gz" ( u-boot version 1.1.4 ) sources
> downloaded from the "linux.omap.com" site, for booting the OMAP2430
SDP
> board
> from NOR flash. I built the sources for booting from NOR flash and
burn it
> using the CSST tool onto the OMAP2430 SDP board. It takes around 2 to
4
> minutes for u-boot command prompt. I am also not able to boot the
linux
> kernel with this version.

Well that shouldn't happen.  I've not seen that before.  However, I'm
not sure which snapshot is on the web.  A couple things come to mind as
possibilities.

-1- You need to set dip switches correctly.

-2- Some code was added for another program which created a path where
udelay was called before the timer was setup properly.  If you are
unlucky this can lock you up.  If you remove its usage in sys_info.c in
the board identification path it may fix your issue.  This is fixed in
later images.

Next week perhaps I can send you a binary which is known to be good.

Regards,
Richard W.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
