From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 11 Mar 2011 11:33:30 -0800
Message-ID: <20110311193330.GA14204@kroah.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299846911-15782-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103111532.52393.arnd@arndb.de>
	<20110311155257.GA6711@kroah.com>
	<20110311175816.GC7291@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110311175816.GC7291@besouro.research.nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel Walker <dwalk>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 11, 2011 at 07:58:16PM +0200, Eduardo Valentin wrote:
> Hello,
> 
> On Fri, Mar 11, 2011 at 07:52:57AM -0800, ext Greg KH wrote:
> > On Fri, Mar 11, 2011 at 03:32:51PM +0100, Arnd Bergmann wrote:
> > > On Friday 11 March 2011, Maxime Coquelin wrote:
> > > > Common base to export System-on-Chip related informations through sysfs.
> > > > 
> > > > Creation of a "socinfo" directory under /sys/.
> > > > Creation of SoC information entries.
> > > > 
> > > > Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>
> > > 
> > > I think it's better than the previous patch to create an
> > > artificial device in /sys/devices/system/socinfo, but I'd
> > > still prefer the information to be attached to a real device
> > > that represents the SOC, as I explained in the discussion with
> > > Linus Walleij.
> > > 
> > > You should definitely add Greg on Cc, as he's maintaining sysfs
> > > and certainly has an opininion here.
> > > 
> > > 	Arnd
> > > 
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-socinfo |   16 ++++++
> > > >  drivers/base/Kconfig                    |    3 +
> > > >  drivers/base/Makefile                   |    1 +
> > > >  drivers/base/soc.c                      |   79 +++++++++++++++++++++++++++++++
> > > >  include/linux/sys_soc.h                 |   50 +++++++++++++++++++
> > > >  5 files changed, 149 insertions(+), 0 deletions(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-socinfo
> > > >  create mode 100644 drivers/base/soc.c
> > > >  create mode 100644 include/linux/sys_soc.h
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-socinfo b/Documentation/ABI/testing/sysfs-socinfo
> > > > new file mode 100644
> > > > index 0000000..afd9da2
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-socinfo
> > > > @@ -0,0 +1,16 @@
> > > > +What:		/sys/socinfo
> > > > +Date:		March 2011
> > > > +contact:	Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
> > > > +Description:
> > > > +		The /sys/socinfo directory contains information about the
> > > > +		System-on-Chip.	It is only available if platform implements it.
> > > > +		This directory contains two kind of attributes :
> > > > +			- common attributes: 
> > > > +				* machine: the name of the machine.
> > > > +				* family: the family name of the SoC
> > > > +			- SoC-specific attributes: The SoC vendor can declare attributes
> > > > +			  to export some strings to user-space, like the serial-number for
> > > > +			  example.
> > > > +
> > > > +Users:
> > > > +		User-space applications which needs these kind of attributes.
> > 
> > I thought I rejected this the last time it came around?
> > 
> 
> Greg,
> 
> Do you mind sharing the link of the thread where you have reject this?

I don't remember it, you can search as well as I can :)

> > I still fail to understand why this is needed, please provide more
> > information about why you feel this is something that the kernel needs.
> 
> In case of OMAP, there are few ids that we would expose to user space,
> like serial, revision and die id to quote some from top of my mind.
> I must emphasize  that these are not data from CPU at all, they belong
> to SoC itself.

I understand, but note that there could be multiple SoC devices, right?
How will this code support that?

Make this a "real" device not /sys/socinfo please.  It can be a platform
device that export the needed information, that way you can have
multiple ones.

thanks,

greg k-h
