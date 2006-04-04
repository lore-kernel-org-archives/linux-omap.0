From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.16-omap2 tagged & patches available
Date: Tue, 4 Apr 2006 14:22:13 -0700
Message-ID: <20060404212212.GH15266@atomide.com>
References: <20060403204428.GN13009@atomide.com>
	<20060404144930.GD15266@atomide.com> <4432DDB7.7080204@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4432DDB7.7080204@am.sony.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Geoff Levand <geoffrey.levand@am.sony.com> [060404 13:57]:
> Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [060403 13:46]:
> >> Hi all,
> >> 
> >> Turns out the MMC bug on H2 and H3 was related to the recent clock id
> >> usgage :)
> >> 
> >> I've tagged 2.6.16-omap1 and posted a patch to the usual location:
> >> 
> >> http://www.muru.com/linux/omap/
> > 
> > I generated a quick 2.6.16-omap2 with the 1510 USB host patch in it.
> > 
> 
> Sorry, seems to be bad.  Nothing inside...
> 
> $ quilt push
> Applying osk-support/patch-2.6.16-omap2
> patch: **** Only garbage was found in the patch input.
> Patch osk-support/patch-2.6.16-omap2 does not apply (enforce with -f)

Oops, that was generated with with cg-patch -s -r, so it was just the
summary. Should have been cg-patch -r only. Can you try now?

Tony
