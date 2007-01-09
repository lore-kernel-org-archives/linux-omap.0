From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH] Update MMC response types
Date: Tue, 9 Jan 2007 15:56:07 -0800
Message-ID: <20070109235606.GW7384@atomide.com>
References: <4586B50A.9030700@indt.org.br> <4586D996.40009@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4586D996.40009@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-omap-open-source@linux.omap.com, Ilias Biris <ilias.biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

* Pierre Ossman <drzeus-list@drzeus.cx> [061218 10:10]:
> Carlos Aguiar wrote:
> > Hi folks,
> >
> > This patch is a fix in order to update MMC response types. This modification
> > is needed to allow SD card support in OMAP platforms.
> >
> > It's based on previously work from Juha Yrjola.
> >
> > This modification was tested in H2 and H3 OMAP platforms using an
> > Transcend SD card 512MB.
> >
> >   
> 
> I'm no fan of coding response types into drivers, but I can understand
> that you're using hardware with a crappy vendor which doesn't properly
> document what the hardware does. This patch at least makes things more
> readable. Ack from me.

Pushing this to linux-omap tree. Pierre, is this in your MMC queue
already?

Regards,

Tony
