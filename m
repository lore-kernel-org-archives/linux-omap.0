From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: GPMC timings for smc91x on 24xx (WAS: Pending July patches)
Date: Thu, 03 Aug 2006 19:00:22 +0300
Message-ID: <44D21D96.7080406@solidboot.com>
References: <EA12F909C0431D458B9D18A176BEE4A506F16A6C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A506F16A6C@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard wrote:

> As far as 2420 vs. 2420POP vs. 2422 vs. 2423 unfortunately early chips
> did not follow a common schema, later ones do, doing things which
> captures them all can be messy.  The mechanism in the OMAP1 port was not
> constructed to work with the multi-stage check which is now necessary.
> This simple example highlights one basic issue.  The current level of
> code sharing as the processors diverge can make it harder to add trivial
> code with out breaking other ones.

Harder, sure, as in "requires more competence to do the initial work". 
Any additional time spent on cleaning up the architecture is saved 
several times over when the bug fixing and maintenance period starts, or 
when support for yet new CPUs are added.  And besides, the more we move 
into a more generic direction with the code, the easier it gets to add 
support for new hardware, and bug fixes for generic code will benefit 
all platforms.

The fact is that the community development model simply does not favor 
branching the code.  I'd also argue that having several code bases does 
not suit proprietary software development that well either, but that is 
another matter altogether.

> This will slow the tree's adoption of new chips. It is hard to say
 > what the sharing balance should be. If
> chips have a long lifetime then code sharing at the low level seems 
> pretty good, if they only live for a couple of years adding some
> extra indirection and maintaining high levels of sharing in the old
> ones starts to lose its value.

Lifetime from whose point of view?  There are users who will be using 
products based on current generation CPUs ten years from now.  The Linux 
kernel still supports hardware and CPUs that existed back when the very 
first version of the kernel was released.

> Production volume vendor time lines
> and their compromises does force branching and fragmentation.

Simply not true.  There are numerous examples of both silicon and device 
volume vendors being able to do quality kernel code and in the end being 
able to get the code merged into mainline without compromising schedules.

> Perhaps one tree can not and should not meet all needs. Keeping high level
> interface compatibly is really good the level of low level can be
> less.

Linus' tree does seem to be doing a fairly good job of meeting almost 
everyone's needs.  Branching the code is simply impossible from 
maintenance point of view due to rapid development speed of the kernel. 
  New features that also benefit the embedded people are added every 
month, bugs and vulnerabilities are fixed daily.  Back-porting them to 
older versions will start consuming more and more time until it just 
becomes impossible.

> One measure might be I know of several vendors in production of OMAP2
> chips for over a year using less well structured trees.

Too bad I don't remember seeing any OMAP2 patches from said vendors. 
The end result is that each vendor will have to spend extra resources 
implementing their drivers separately, with each driver having bugs of 
their own.

Cheers,
Juha
