From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Driver OMAP 3430
Date: Fri, 31 Jul 2009 10:35:49 +0300
Message-ID: <20090731073549.GB5551@nokia.com>
References: <d9ca78710907300430k16dd1a76pd4801c3ae2495b47@mail.gmail.com>
 <20090730114651.GB31673@nokia.com>
 <d9ca78710907310016g25874ccbtb925982e631e0e59@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63831 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbZGaHfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 03:35:22 -0400
Content-Disposition: inline
In-Reply-To: <d9ca78710907310016g25874ccbtb925982e631e0e59@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tar Gz <bsdraisefromhell@gmail.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

hi,

adding linux-omap back to the loop

On Fri, Jul 31, 2009 at 09:16:43AM +0200, ext Tar Gz wrote:
> On 7/30/09, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> > On Thu, Jul 30, 2009 at 01:30:44PM +0200, ext Tar Gz wrote:
> >> hello everybody
> >>
> >> i'm student from indonesia..i'm sorry if my english too bad
> >>
> >> i want omap 3430 device drivers can running in the linux, where i can
> >> download any driver for omap 3430?..
> >
> > which driver ? For which device ?
> >
> > google a little bit about how to use "git" and you can download current
> > linux omap with:
> >
> > git clone
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> >
> > --
> > balbi
> >
> 
> all device driver omap 3430 like usb driver,camera driver, etc

usb is there, both musb and ehci. Camera isn't integrated yet. Audio
should be in good shape but i'm not sure.

Well, download it and you can check.

-- 
balbi
