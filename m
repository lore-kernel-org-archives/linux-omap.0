From: Tony Lindgren <tony@atomide.com>
Subject: Re: omapfb: fix build for n770
Date: Fri, 2 Mar 2007 04:15:41 -0800
Message-ID: <20070302121540.GE6955@atomide.com>
References: <85odnu2ymk.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85odnu2ymk.fsf@orfeo.duckcorp.org>
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

* Arnaud Patard <arnaud.patard@rtp-net.org> [070216 02:20]:
> This patch fix the build breakage introduced by the n800 fb update. It
> has not been tested but at least the kernel is building now.
> The change from sossi_extif to omap1_ext_if has been suggested by the
> os2007on770 project
> (http://maemo.org/maemowiki/Os2007On770?highlight=%28os2007%29).
> 
> [ Checking that the n770 defconfig is still building after adding a n800
> update would be nice. It's known that the n800 2.6.18 kernel has some
> not-n770-friendly changes ]

Pushing today.

Tony
