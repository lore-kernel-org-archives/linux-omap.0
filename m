From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] musb_hdrc: Replace MGC_ with MUSB_, misc OPT test
	fixes
Date: Sun, 19 Aug 2007 23:15:11 -0700
Message-ID: <20070820061511.GC16454@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<46C5D95B.6030709@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46C5D95B.6030709@mvista.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070817 10:22]:
> Tony Lindgren wrote:
> > Hi all,
> > 
> > Attached patch series gets rid of the last MGC_ occurances
> > replacing them with MUSB_ as these variables are MUSB driver
> > specific and not common to all Mentor drivers.
> > 
> > Also few HS OPT fixes that make the tests run reliably
> > even the same tests are run multiple times.
> > 
> > Tested on tusb.
> 
> Tested current git plus this set on Davinci.  Basic tests on host and
> gadget OK.

Thanks for testing. I'll push these today, and will be doing more
clean-up over next few weeks.

Regards,

Tony
