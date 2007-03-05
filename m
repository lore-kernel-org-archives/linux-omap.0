From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Update N800 defconfig
Date: Mon, 5 Mar 2007 03:48:32 -0800
Message-ID: <20070305114831.GD17801@atomide.com>
References: <45EA9F87.6090300@googlemail.com>
	<85649hjnnp.fsf@orfeo.duckcorp.org>
	<45EAB2E7.1000607@googlemail.com>
	<85y7mdgpww.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85y7mdgpww.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [070304 04:27]:
> Dirk Behme <dirk.behme@googlemail.com> writes:
> 
> > Arnaud Patard (Rtp) wrote:
> >>>Update N800 defconfig, mainly to disable netfilter which
> >>>doesn't compile:
> >>  Fixing the build may be a better idea than disabling it.
> >
> > Yes, your are right ;) But this is something we can't do here on OMAP
> > list.
> 
> I disagree. This driver afaik can only be found in the omap tree and
> it's only a matter of taking few minutes to update the driver to follow
> upstream changes. So, unless the original author of the driver fixes it
> (which I doubt), it's up to us to fix it.

Thanks, can you please add a Signed-off-by to this thread? I'll add
your patch to the "Add iptables IDLETIMER target" patch in omap-drivers
branch. Once it's been tested we should try to send it upstream when the
next merge window opens.
 
> As I said, I have a patch for it. I'm attaching it to this mail for
> reference because I'm now thinking that I won't be able to test it on my
> n770.

Binary firmware issue with compiling wlan driver I suppose? :(

Regards,

Tony
