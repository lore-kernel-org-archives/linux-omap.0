From: Tony Lindgren <tony@atomide.com>
Subject: Re: most recent kernel version to use with OMAP2420
Date: Tue, 26 Jun 2007 23:29:10 -0700
Message-ID: <20070627062908.GA2225@atomide.com>
References: <1182892909.3642.21.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1182892909.3642.21.camel@linux>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Andray Kaganovsky <andrayk@fcibroadband.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Andray Kaganovsky <andrayk@fcibroadband.com> [070626 14:25]:
> Hello,
> 
> I am trying to figure out which kernel version should I use with
> my OMAP2420 board (I would prefer one of the most recent versions).
> 
> I have downloaded repository from
> git://source.mvista.com/git/linux-omap-2.6.git, and found that
> it contains few dozens of kernel versions; ten of them
> have "omap" as part of their names:  
> 
>     v2.6.13-omap1
>     v2.6.14-rc1-omap1
>     v2.6.15-omap2
>     v2.6.16-omap1
>     v2.6.16-omap2
>     v2.6.17-omap1
>     v2.6.17-omap2
>     v2.6.18-omap1
>     v2.6.19-omap1
>     v2.6.21-omap1
> 
> Are the "omap" versions specifically patched for OMAP boards ? Do
> I have a better chance of getting "omap" versions to work with
> OMAP2420 board then the versions which don't have "omap" in their
> names ?

Yes, -omap kernels are "stable" snapshots from linux-omap tree.
They have more boards and drivers compared to Linus' tree.
I recommend using the linux-omap git tree or latest stable
release.

> Does anybody actually got any of these versions to work with
> OMAP2420 ?

At least TI H4 and Nokia N800 are well supported in the
linux-omap tree. Adding new boards is trivial.

> Thanks in advance and regards,

No problem,

Tony
