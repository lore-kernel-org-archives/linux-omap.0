From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Anybody working on tidspbridge?
Date: Tue, 8 Jul 2014 07:36:59 -0700
Message-ID: <20140708143659.GB3104@kroah.com>
References: <53A4569B.70604@gmail.com> <53A45BBD.4040201@gmail.com>
 <20140629164250.GA31625@kroah.com> <53BBE895.4020105@gmail.com>
 <alpine.DEB.2.01.1407081452580.5181@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.01.1407081452580.5181@pmeerw.net>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 08, 2014 at 03:03:58PM +0200, Peter Meerwald wrote:
> Hello,
> 
> > > Given the total lack of response here, I suggest just deleting the
> > > driver.  No one has ever done the "real work" that is going to be
> > > required to get this code out of staging.  It has had build errors
> > > causing it to not even be usable for some kernel versions with no one
> > > noticing, so I doubt anyone cares about it anymore here.
> > 
> > Cc'ing some more people who might be interested. If no one offers to
> > work on the driver in the next couple of days, I'll send a patch to
> > remove it.
> 
> I'm using the driver (with kernel 3.7) and it works reasonably well for 
> me; removing it seems a bit harsh

Using it is different from being able to maintain the code and move it
out of the staging tree.  Also, 3.7 is really old and obsolete, not much
we can do with that kernel version :)

Are you able to work on the code and do the effort needed to get it out
of the staging tree?  If so, great, if not, we are going to have to
delete it, sorry.

greg k-h
