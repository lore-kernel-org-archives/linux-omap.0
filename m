From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/5] staging: tidspbridge: for 3.9
Date: Sun, 20 Jan 2013 15:51:27 -0800
Message-ID: <20130120235127.GA799@kroah.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
 <20130118004746.GA8897@kroah.com>
 <CAJ6Av5M1o9CW=pfWTw_8HY7rfW4sPi6P+p3NY2Q1YErTeptfww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:65138 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab3ATXvb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jan 2013 18:51:31 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so2420894dak.6
        for <linux-omap@vger.kernel.org>; Sun, 20 Jan 2013 15:51:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJ6Av5M1o9CW=pfWTw_8HY7rfW4sPi6P+p3NY2Q1YErTeptfww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: devel@driverdev.osuosl.org, Tony Lindgren <tony@atomide.com>, Chen Gang <gang.chen@asianux.com>, linux-omap@vger.kernel.org

On Sun, Jan 20, 2013 at 05:45:16PM -0600, Omar Ramirez Luna wrote:
> Hi Greg,
> 
> On Thu, Jan 17, 2013 at 6:47 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jan 10, 2013 at 03:36:57AM -0600, Omar Ramirez Luna wrote:
> >> Patches for staging-next, fixing comments and suggestions provided
> >> by Chen Gang.
> >>
> >> There is an additional scm patch, that removes hardcoded defines
> >> related to direct register handling for SCM, it was dependent on
> >> changes that already made it to mainline.
> >
> > What is the status on getting this out of the staging tree?
> 
> I'm currently working to do this.
> 
> >  What needs
> > to be done still?
> 
> - There is a tasklet that I'm working to remove.
> - Some portions could be fitted into remoteproc (as Tony mentions).
> - Migration to generic iommu framework.
> - Need to rework patches to use request_firmware.
> - And a thorough cleanup to get rid of if-else nesting.

That looks good, care to update the TODO file for the driver in the
kernel to reflect this?

thanks,

greg k-h
