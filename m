From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending April patches
Date: Wed, 2 May 2007 17:21:08 +0000
Message-ID: <20070502172108.GD3520@atomide.com>
References: <46374339.4030102@googlemail.com>
	<20070502084714.4a23397d.jarkko.nikula@nokia.com>
	<57314e840705012317m45e2d42y3120f2247393d8f7@mail.gmail.com>
	<5d5443650705020134n55148159i4d30a35b12695a66@mail.gmail.com>
	<57314e840705020149v194e4807j886a7efaa15f324@mail.gmail.com>
	<5d5443650705020246v3e4427b9t9290d3e18de4ff4b@mail.gmail.com>
	<57314e840705020407q4823911i508d7ad24da47302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <57314e840705020407q4823911i508d7ad24da47302@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Budhee Jamaich <budheej@gmail.com> [070502 11:13]:
> On 5/2/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> 
> >> > > Can you please explain me against what source tree you people are
> >> > > sending patches here ?
> >> > > 
> >http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=tree;h=52cbee1227465a23c586734fb1226276bfee877b;hb=52cbee1227465a23c586734fb1226276bfee877b
> >> Hmm ok. and is this source tree good for any OMAP ? 2430 too ?
> >>
> >
> >It depends on what are the "good" things you are expecting from
> >particular OMAP support in this GIT tree. OMAP2430 core and TWL4030
> >support is included in GIT tree, and Syed is working on adding GPIO
> >and Keypad driver.
> >
> >You can help by porting the drivers/support you want to see in latest
> >kernel by porting them from TI's kernel tarballs.
> 
> Let me see I understand this.
> TI has published two kernel tarballs - 2.6.10 and 2.6.14 which fully
> supports the OMAP.
> But - the community is working on this git source tree, which is up-to-date
> with current kernel, and slowly port code from TI's code into the git tree ?

Well the TI trees are also based on older snapshots of the linux-omap tree.

Ideally there would be only minimal lag between the linux-omap tree and
TI's product snapshot trees of course.

But you can actually use most of the omap boards with the linux-omap
tree, you may need to apply few driver patches and the PM support
varies.

Regards,

Tony
