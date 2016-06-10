From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Fri, 10 Jun 2016 17:23:11 +0200
Message-ID: <86213272.dICX26rd7d@saturn>
References: <201601091616.04193@pali> <2981817.IalgiMo2nt@saturn> <20160610150808.GA28283@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160610150808.GA28283@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri 10 June 2016 10:08:08 Bin Liu wrote:
> Hi,
> 
> On Thu, Jun 09, 2016 at 11:25:57PM +0200, joerg Reisenweber wrote:
> > On Thu 09 June 2016 15:58:56 Bin Liu wrote:
> > > But I am not sure how this will fix n900 host mode problem, since
> > > testmode is not used in normal operation.
> > 
> > Please see http://talk.maemo.org/showthread.php?p=685367 and
> > http://maemo.org/packages/view/hostmode-gui/ which indeed is _no_ normal
> > hostmode but an implementation of a workaround that exploits the force
> > host
> > test mode (among others)
> 
> What I meant was that it is okay for hobby, but you don't want to
> something that the IP vender does not support in real products.


You lost me. 
> > > But I am not sure how this will fix n900 host mode problem
http://maemo.org/packages/view/hostmode-gui/ and the associated kernel patches 
for FORCE_HOSTMODE _is_ how we 'fix' the N900 hostmode problem (see 
https://www.youtube.com/watch?v=fkCDyUO0sKQ for a proof)

/j
-- 
()  ascii ribbon campaign
/\  
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml          
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml    
http://www.gerstbach.at/2004/ascii/ (German)
