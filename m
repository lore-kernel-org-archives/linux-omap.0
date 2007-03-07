From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] board_nokia770: add hwa742 platform data
Date: Wed, 7 Mar 2007 00:26:54 -0800
Message-ID: <20070307082652.GD21093@atomide.com>
References: <85ejo5i6g9.fsf@orfeo.duckcorp.org>
	<20070306164814.GB4450@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070306164814.GB4450@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Imre Deak <imre.deak@solidboot.com> [070306 08:55]:
> On Sun, Mar 04, 2007 at 12:39:02PM +0100, Arnaud Patard wrote:
> > 
> > The n800fb changes introduced some platform_data for the hwa742 and
> > needs now to be defined for getting it working.  This patch adds the
> > necessary bits needed for getting fb working again on n770.
> > This patch comes from the n800 kernel from maemo.org
> > 
> > 
> > Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
> Thanks for pointing this out. In this updated patch I adding missing init
> / registration for other devices, as well as API fixes for the SoSSI /
> HWA742 code.
> 
> With these LCD, touchscreen should work ok on the N770, after the
> omap_uwire code is merged from upstream.

Pushing patch 1 to omap-upstream, 2 - 3 to omap-drivers, and 4 to master
branch.

Tony
