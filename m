From: Aishwarya Pant <aishpant@gmail.com>
Subject: Re: misc: bh1770glc: move sysfs interace to Documentation/ABI
Date: Tue, 2 Jan 2018 22:55:16 +0530
Message-ID: <20180102172516.vfc4uf43mappt3um@mordor.localdomain>
References: <20171226092957.GA3817@mordor.localdomain>
 <20180102130636.GA20209@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180102130636.GA20209@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samu Onkalo <samu.p.onkalo@nokia.com>, julia.lawall@lip6.fr, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 02, 2018 at 02:06:36PM +0100, Pavel Machek wrote:
> Hi!
> 
> > In Documentation/misc-devices/bh1770glc.txt, there is a description of the sysfs
> > interface which could be moved to Documentation/ABI.
> > 
> > Would such a change be useful?
> 
> Not at the moment.
> 
> > The ABI documentation format looks like the following:
> > 
> > What:          (the full sysfs path of the attribute)
> > Date:          (date of creation)
> > KernelVersion: (kernel version it first showed up in)
> > Contact:       (primary contact)
> > Description:   (long description on usage)
> > 
> > I am doing this in an exercise to move sysfs ABI interfaces (which are
> > documented) to their right place i.e. in Documentation/ABI along with the rest.
> 
> The interface should probably be changed to iio one, to be consistent
> with other sensors such as Apds990x.
> 
> If you have the hardware, help would be welcome.

Yes, makes sense for this driver to be with the iio light sensors. I don't have
the hardware for it. So, I won't move the sysfs interface to ABI.

Aishwarya

> 
>   	      	       	     	   	   		     	   	Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
