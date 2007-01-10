From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending December (January) patches
Date: Wed, 10 Jan 2007 11:17:20 -0800
Message-ID: <20070110191720.GG3219@atomide.com>
References: <459E6FE4.5030208@googlemail.com>
	<20070109235912.GX7384@atomide.com> <45A51EC9.50007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45A51EC9.50007@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Dirk Behme <dirk.behme@googlemail.com> [070110 09:14]:
> Tony Lindgren wrote:
> >These should be applied now, everybody please check your patches got
> >applied OK.
> 
> Except the two patches which need update our pending patches 
> list is now empty :) Thanks!

:)
 
> What do you think about preparing stuff for 2.6.21 upstream 
> merge window now? 2.6.20-rc4 is there and it looks like this 
> is a calmer release, maybe 2.6.20 is coming in time.

Yes, I'll update that probably next week so we'll be ready well
ahead.
 
> I think frist we should remove our old stuff from RMKs patch 
> tracking system. It is still in incoming state [1]. Then 
> send the updates so RMK can early comment on it. With some 
> luck we hit the 2.6.21-rc1 window.

I agree. If we have conflicting patches, it may cause some delays
getting the big patch set applied. I just marked the previous core
omap patches as superceded.

Does anybody have bug fixes that should go to mainline before
the big merge? If there aren't any urgent ones, I suggest we
wait for 2.6.20 to make the big merge easier.
 
> Tony: Not sure about your current workload, maybe people can 
> help?
>
> All: Opinions?

I've scheduled some time for this and the patch queue is now pretty
easy to update. Also I've scripted out some parts :) So I think we're
in good shape for sending out the core omap patches.

Where people can help is picking an individual driver subsystem to
clean up for sending it upstream.

Imre will be sending out the framebuffer patches when he has a chance.
But at least sound and v4l driver code should be cleaned up and
sent upstream.

Anybody interested in working on merging audio and/or v4l?

Regards,

Tony
 

> [1] 
> http://www.arm.linux.org.uk/developer/patches/section.php?section=0
