From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB driver issue
Date: Thu, 31 Jul 2008 23:30:24 -0700
Message-ID: <20080801063024.GE8634@kroah.com>
References: <20080731163634.GA9606@kroah.com> <368260.89826.qm@web53203.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <368260.89826.qm-ddnbr+Bmt6iB9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 31, 2008 at 01:38:59PM -0700, Emanoil Kotsev wrote:
> > Either way, it's not a kernel issue, how could you
> > blame 2.6.20 for gcc 4.3 issues when gcc 4.3 was not even released
> > when .20 was released?  Are us kernel people time travellers?
> 
> :-) good point. Everytime I switch to a new kernel I have to download
> a bunch of different versions of drivers and software and compile
> them, install them and test them and end up with a bunch of new bugs.

Why are you needing to download new drivers?  Is not everything you need
already in the main kernel tree?  What is missing?

> I don't have the time recently to play this nasty game and I'm getting
> tired Why should I do this? I just want to fix problems in current
> kernel that I'm using.  I would agree with you if new versions do not
> come with new bugs, but they do, thus my suggestion.

All software has bugs, it's how we treat them that matters.

> > > So what I'm pleading for is to focus on stability!
> > 
> > What exactly do you propose for such a "focus"?  How do you see this
> > happening?
> 
> Kernel developers should fix bugs in minor kernel versions as they are
> meant for this purpous and do major changes only in major version. A
> bunch of bugfixes I see (not only usb related) are just not in place
> in minor kernel versions. That's my opinion at first place.

Minor (2.6.x.y) releases happen with only bugfixes every few weeks.
Perhaps you should use them.  But realize that they are only supported
for about 3-4 months, then you are expected to move to the next major
release.

That's how the community works, it is insane for us to do otherwise,
just for the overhead alone.

> Second if you want to have me as happy linux user developers should
> agree to support older versions to help embeded and other developers
> working further on their projects.

Given the rate of change in the Linux kernel (faster than any other
software project known to man), how do you really expect us to do that?
It's pretty impossible.

> > Closed source drivers have issues, film at 11.  Bah, take
> > it up with them, there is NOTHING that us developers can do about
> > that, sorry.
> 
> You are neglecting the point and kind of insulting me! So you think I
> should spent my time convincing about 20 people from different
> companies to recompile their software because I was told by you to
> upgrade to fix a usb issue or a kind that is not related to their
> software and when they finally do it there is a already a new kernel
> version ... sorry I can not agree with any of you on this point. You
> want me to spent my time contacting people and not working on my
> projects ;-)

No, we expect that you would use hardware that works with, and
contributes toward the advancement of Linux.  Not hardware that requires
closed source modules.

Again, if you are stuck with such hardware, there is _nothing_ that I or
any other kernel developer can do about it.  It is physically
impossible.

> Why just not be able to patch my old kernel without breaking the
> ability to use the software I already have installed and is working
> with the version I use?

With the exception of kernel modules, it should all "just work".  If
not, please let us know and we will fix it.

> I think this is the question no body wants to answer and I think there
> is a problem with you guys. What are you doing this development if
> some people are not happy with it and have reasonable arguments.
> 
> May be the patches should be split into smaller files related to bugs
> - just an idea!

We do that already with the -stable release.

Also, every single patch that goes into the kernel is available
separately if you so desire it.

> You experience a bug and patch - the bug is gone you are happy.
> May be there should be some longer period to support at least the
> latest stable releases ... but something should be done.

If anyone wants to step up and maintain a specific kernel release longer
than the current -stable team does so, they are more than willing to do
so.  2 people have done this in the past quite well.

But note, it is a _lot_ of real hard work.  Trust me, I've been doing it
myself for a long time now...

> I know the Linus policy conserning 2.6. tree has changed for the
> reason to let us improve faster, but since 1-2 years I have the
> feeling 1) that it is getting too fast and 2) that I'm not the only
> one saying this

If it's "getting too fast", then that's fine, some people are not
comfortable with rapid change.  Other operating systems change much
slower, perhaps one of them would work out better.

But right now, the Linux kernel is moving very rapidly.  Like it has for
the past 5 years (I have the numbers to back that up...)

Remember, we are changing for real reasons, who is to tell a devloper
that the reason for a change is not allowed just because we want to slow
down?  Does that not make their need somehow less than someone elses?

We change because the world changes.  In order to survive, we also need
to change.

If we stop, we die.

> > Applications are a different story, they should "just work" with
> > different kernel versions, there should not be any problems there.
> > If there are, let the kernel developers know, we take backwards
> > userspace compatiblity VERY seriously.
> 
> gcc-4.3 ;-) is it application or what do you mean ... the compiler is
> not an application ;-)

gcc 4.3 runs just fine on 2.6.22.  It's the fact that you want to _use_
gcc 4.3 to build 2.6.22 that is an issue.  They are two totally
different things here.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
