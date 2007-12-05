From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH: Resending] - onenand - OMAP3 support - Kconfig update
Date: Wed, 5 Dec 2007 15:08:14 -0800
Message-ID: <20071205230813.GD4105@atomide.com>
References: <20071128210911.GZ11825@atomide.com>
	<6E3DC4E6E09EF440B55B7AD683608D6D0288A373@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <6E3DC4E6E09EF440B55B7AD683608D6D0288A373@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: Felipe Balbi <ext-felipe.lima@nokia.com>, linux-omap-open-source@linux.omap.com, ext Sameer <x0081444@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kamat, Nishant <nskamat@ti.com> [071205 13:18]:
> Hi Tony,
> 
> > -----Original Message-----
> > From: Tony Lindgren
> > Sent: Wednesday, November 28, 2007 3:09 PM
> > 
> > * Felipe Balbi <ext-felipe.lima@nokia.com> [071128 08:56]:
> > > On Wed, Nov 28, 2007 at 11:20:38AM +0530, ext Sameer wrote:
> > > > Hi,
> > > > Please ignore the previous patch.
> > > > The following patch provides the onenand support for OMAP3.
> > > > The patch enables the onenand in def_config file, enable 
> > onenand Kconfig for OMAP3 and redeclaring the 
> > omap2_sleep_block(), omap2_allow_sleep() according to 
> > CONFIG_PM defination in pm.h according to Felipe Balbi's comments.
> > 
> > Pushing today.
> > 
> > Tony
> 
> Seems like this patch is not merged yet..

Sorry, I must have forgotten to do git-am after refreshing it as a
quilt patch... Pushed now, can you please check?

Tony
