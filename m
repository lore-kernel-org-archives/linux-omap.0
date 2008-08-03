From: Emanoil Kotsev <deloptes@yahoo.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 17:11:51 -0700 (PDT)
Message-ID: <636531.20956.qm@web53210.mail.re2.yahoo.com>
References: <20080802182717.GA12051@kroah.com>
Reply-To: deloptes@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web53210.mail.re2.yahoo.com ([206.190.49.80]:39973 "HELO
	web53210.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751726AbYHCALw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Aug 2008 20:11:52 -0400
In-Reply-To: <20080802182717.GA12051@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Greg, the discussion is getting out of control.

I think you are one of the few that understand what we are talking about (may be not compleetly but at least you are not confronting with statements that make me angry) and it seems that you are trying to find a compromise. So I'll write only this one mail and get out of this discussion.

First I do not consider 2.6.22 new, but it would be nice to have longer life cycles.
The problem is that we talk to different 3rd party vendors who re willing to help but can not follow this speed and the changes you do.
At the other hand the kernel needs more testing to step to next level of development.
If you can not do it I would understand it, but this way I'm afraid to install 2.6 kernel on a server, where data storing is done. I did it with 2.6.24 had some oops on the usb (ehci) and end up with restoring raid over 10hours, that's how I came to the usb list.

These two aspekts (issues) are my consern about what you label as old and I just wanted to find out if something could be done to help everybody. I'm working as consultant and could promote linux, but I won't do it for post 2.6.20 kernel versions.
It's just not confident. I could offer a SuSE, RedHat or a kind  of support, what I'm also doing, but this is a different issue.
It is also for me as user and working person with a private life almost not possible to follow the development and to test and check everything. I have equivalent machine and periferal equipment where I could test, but it is very time consuming so I'm looking for solution how we can mutually benefit and not loose confidence in each other.
May be there should be a server and desktop branch (it is an idea) but this situation and also with such confrontation from the developers is very very sad.
At least I'm not writing it to argue with you but to have a meaningful discussion where we could reach some kind of agreement at the end.

If you wish to you could mail me on my mail address, I don't want to continiue the discussion here any more and bother the list participants

thank you for (may be) understanding the point

regards

--- On Sat, 8/2/08, Greg KH <greg@kroah.com> wrote:

> From: Greg KH <greg@kroah.com>
> Subject: Re: USB driver issue
> To: "Emanoil Kotsev" <deloptes@yahoo.com>
> Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
> Date: Saturday, August 2, 2008, 8:27 PM
> On Sat, Aug 02, 2008 at 02:53:08AM -0700, Emanoil Kotsev
> wrote:
> > I'll stop this discussion. If you feel you are
> right, then this should
> > be true and I don't mind it.
> > 
> > The problem was with you calling 2.6.22 a "such
> old", but I give up
> > this discussion too. You have the right to think it is
> and I have the
> > right to do not. After I have your point of view I
> have to live with
> > that, hope the same for you.
> 
> 2.6.22 is "old".  It was released a full year
> ago.
> 
> Since then, 38682 changes have been made to the Linux
> kernel source
> tree.
> 
> That's a _lot_ of changes.  So as you can see, lots of
> things have
> changed in the past year, making it _very_ difficult for
> the community
> to support such an old kernel release.
> 
> > It would be anyway nice if you do not make such
> (2.6.22 - "such old")
> > statments, but if you wish you could and I don't
> mind either. 
> 
> Based on the rapid development of the Linux kernel, I'm
> confused as to
> how you could consider 2.6.22 a "new" kernel?
> 
> > I think I'll spend my time filing bugs instead of
> arguing with you, as
> > it leads to nothing obviously.
> 
> Please do, we will be glad to fix them as well as we can.
> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line
> "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
