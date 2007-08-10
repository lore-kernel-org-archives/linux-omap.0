From: Tony Lindgren <tony@atomide.com>
Subject: Re: N800 experimental host mode patches available
Date: Fri, 10 Aug 2007 00:36:27 -0700
Message-ID: <20070810073626.GH8658@atomide.com>
References: <fb249edb0706100459w731695c7odce6714b414e3b91@mail.gmail.com>
	<20070612183523.GF29514@atomide.com>
	<20070612184541.GG29514@atomide.com>
	<20070612180454.r98jy42408dcc8sk@webmail.caflor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070612180454.r98jy42408dcc8sk@webmail.caflor.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: robert.vogt@caflor.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* robert.vogt@caflor.net <robert.vogt@caflor.net> [070612 17:05]:
> Hi,
>
> I've been experimenting with the 2.6.18 backport of the host mode patches.  
> When
> I run the 2.6.18 kernel:
> kernel-source-rx-34_2.6.18.orig.tar.gz
> kernel-source-rx-34_2.6.18-osso40.diff.gz
>
> ...the peripheral mode works correctly.  When I run the kernel with the 
> host
> patches:
> patches-tusb-n800-2007-05-04.tar.gz
>
> ...neither mode seems to work correctly.  The N800 does not respond to the
> peripheral mode, either in the bootup OTG mode or when explicitly in 
> peripheral
> mode.  As well, the host mode doesn't seem to do anything, although I saw 
> it
> output 5V on the connector one time (and exactly one time, not sure why 
> it's
> not repeatable).  Any ideas?  Can I use the 2.6.21 kernel it's backported 
> from?
> Any special config options besides the defaults for it?  And where can I 
> get
> that?  Thanks.

No idea, except it has been working for me and others :)

Tony
