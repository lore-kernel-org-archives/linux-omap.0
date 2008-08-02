From: Emanoil Kotsev <deloptes@yahoo.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 01:51:59 -0700 (PDT)
Message-ID: <604137.34126.qm@web53204.mail.re2.yahoo.com>
References: <20080801063024.GE8634@kroah.com>
Reply-To: deloptes@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web53204.mail.re2.yahoo.com ([206.190.49.74]:30290 "HELO
	web53204.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752264AbYHBIwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Aug 2008 04:52:04 -0400
In-Reply-To: <20080801063024.GE8634@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vge>


Greg thank you for taking your time to discuss the issue, I think it is important, because both parties have to say something meaningful - you as developer and maintainer and me as user, tester and volunteer

--- On Fri, 8/1/08, Greg KH <greg@kroah.com> wrote:

> From: Greg KH <greg@kroah.com>
> Subject: Re: USB driver issue
> To: "Emanoil Kotsev" <deloptes@yahoo.com>
> Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
> Date: Friday, August 1, 2008, 8:30 AM
> On Thu, Jul 31, 2008 at 01:38:59PM -0700, Emanoil Kotsev
> wrote:
> > > Either way, it's not a kernel issue, how
> could you
> > > blame 2.6.20 for gcc 4.3 issues when gcc 4.3 was
> not even released
> > > when .20 was released?  Are us kernel people time
> travellers?
> > 
> > :-) good point. Everytime I switch to a new kernel I
> have to download
> > a bunch of different versions of drivers and software
> and compile
> > them, install them and test them and end up with a
> bunch of new bugs.
> 
> Why are you needing to download new drivers?  Is not
> everything you need
> already in the main kernel tree?  What is missing?

I am using a dell notebook. I also support my father and wife who have also notebooks (toshiba and fujitsu).
We all have pretty a like set of hardware (from different vendors and in different versions of course) but in general it is

modem, wireless, video (intel, Nvidia, ATI), pcmcia, MMS/SD slot, firewire, irda, bluetooth.
I'm using a hybrid tv usb stick and uvc webcam.

- the modem is not working
- wireless (ipw3945) is not included in the mainstream kernel (after compile and isntall it works)
- uvcvideo driver is included in the latest kernel version and is working (thanks)
- analog/dvb tv stick is not working as I see it has been included in recent version (2.6.26) but it is looking for the wrong firmware or it is simply a code with the same name meant to support the HVR-950 instead of HVR-900 stick.
- I forgot to mention that I'm not able to sync my phones, so there is a chaos in my contacts since I gave up my Palm III and lost my Siemens S55 that was working somehow
- I also use a Geode based low power (7W) pc as a firewall with (take a deep breath) 2.6.11 (but there are now problems with this)

I also have a pentium III machine that works as a server where all our data is stored and backuped, but this is a different issue I mention it only to underline the fact that it is practically impossible to compile and test there

My father and my wife have a big trouble with the (ATI,NVidia) drivers for their video output and I have a big trouble with dual screen, 3D and intel chip

So because of all this issues and taken the fact that I am not a developer but kind a tester that reads and writes C/C++ code from time to time and also thinking in terms of the video you've send I come to the conclusion that it is getting a bit complicated to keep up with you - the developers. Hense the question if we can not agreee to have a kind of stable released where we only fix bugs - but you have already answered the question - there are planty of commercial companies that would do so.

Talking about such companies I don't see the point to use linux at all, because getting payed support for instance from SuSE brings me to the idea that I could buy an Apple PC with more benefit at the end.

Hence the question, also having the presentation about kernel development in mind, are you developing the kernel as a kind of sport ... or are you developing it so that someone can use it for something?

> 
> > I don't have the time recently to play this nasty
> game and I'm getting
> > tired Why should I do this? I just want to fix
> problems in current
> > kernel that I'm using.  I would agree with you if
> new versions do not
> > come with new bugs, but they do, thus my suggestion.
> 
> All software has bugs, it's how we treat them that
> matters.

You treat them right but not in long terms and this is making me nervous

> 
> > > > So what I'm pleading for is to focus on
> stability!
> > > 
> > > What exactly do you propose for such a
> "focus"?  How do you see this
> > > happening?
> > 
> > Kernel developers should fix bugs in minor kernel
> versions as they are
> > meant for this purpous and do major changes only in
> major version. A
> > bunch of bugfixes I see (not only usb related) are
> just not in place
> > in minor kernel versions. That's my opinion at
> first place.
> 
> Minor (2.6.x.y) releases happen with only bugfixes every
> few weeks.
> Perhaps you should use them.  But realize that they are
> only supported
> for about 3-4 months, then you are expected to move to the
> next major
> release.

This is the issue 3-4 months are enough for ATI or NVidia to bring a new driver
Either change the policy or find a solution!

> 
> That's how the community works, it is insane for us to
> do otherwise,
> just for the overhead alone.

May be I put another question: what are the plans for moving to 2.7 or 2.8 kernel then the 2.6. tree will be open only for bug fixes. The changes compared to 2.4 are extreem so if I would like to take advantage of features in 2.6 kernel I should live with bug fixes and support denial in any 2.6 version

> 
> > Second if you want to have me as happy linux user
> developers should
> > agree to support older versions to help embeded and
> other developers
> > working further on their projects.
> 
> Given the rate of change in the Linux kernel (faster than
> any other
> software project known to man), how do you really expect us
> to do that?
> It's pretty impossible.

The question is - what are you doing this for? What's your goal - I'm going to give up linux soon if it goes this way

> 
> > > Closed source drivers have issues, film at 11. 
> Bah, take
> > > it up with them, there is NOTHING that us
> developers can do about
> > > that, sorry.
> > 
> > You are neglecting the point and kind of insulting me!
> So you think I
> > should spent my time convincing about 20 people from
> different
> > companies to recompile their software because I was
> told by you to
> > upgrade to fix a usb issue or a kind that is not
> related to their
> > software and when they finally do it there is a
> already a new kernel
> > version ... sorry I can not agree with any of you on
> this point. You
> > want me to spent my time contacting people and not
> working on my
> > projects ;-)
> 
> No, we expect that you would use hardware that works with,
> and
> contributes toward the advancement of Linux.  Not hardware
> that requires
> closed source modules.

I spent a lot of time reading about hardware and linu support when IO bought my dell notebook, that's why I choose one with intel video vard inside ... and what happened - I don't have 3D when using dual screen - GREAT!

I know what's wrong with 3D but your statement (or recommendation) brings me to the idea that I could also use a type writer

> 
> Again, if you are stuck with such hardware, there is
> _nothing_ that I or
> any other kernel developer can do about it.  It is
> physically
> impossible.

The problem is, that ATI, NVidia and a lot of other hardware producers are willing to support linux, but can not afford it to bring up drivers for the latest stable kernel in the terms you consider it as stable - and this was my original point.

> 
> > Why just not be able to patch my old kernel without
> breaking the
> > ability to use the software I already have installed
> and is working
> > with the version I use?
> 
> With the exception of kernel modules, it should all
> "just work".  If
> not, please let us know and we will fix it.

Then fix the hfs modem for my dell notebook  (oh ... it is closed driver by connexant - but they are willing to help me and .... oh, they suggest I use the 2.6.24 kernel)
And also please fix the em28* driver to work with my hybrid HVR-900 properly as it does with the v4l-dvb tree in 2.6.24

Do you understand what I mean with this discussion?


> 
> > I think this is the question no body wants to answer
> and I think there
> > is a problem with you guys. What are you doing this
> development if
> > some people are not happy with it and have reasonable
> arguments.
> > 
> > May be the patches should be split into smaller files
> related to bugs
> > - just an idea!
> 
> We do that already with the -stable release.
Where are patches for 2.6.26?
> 
> Also, every single patch that goes into the kernel is
> available
> separately if you so desire it.

> 
> > You experience a bug and patch - the bug is gone you
> are happy.
> > May be there should be some longer period to support
> at least the
> > latest stable releases ... but something should be
> done.
> 
> If anyone wants to step up and maintain a specific kernel
> release longer
> than the current -stable team does so, they are more than
> willing to do
> so.  2 people have done this in the past quite well.

I want to know more about it

> 
> But note, it is a _lot_ of real hard work.  Trust me,
> I've been doing it
> myself for a long time now...

Yes this is for sure, but for few taasks it might be useful

> 
> > I know the Linus policy conserning 2.6. tree has
> changed for the
> > reason to let us improve faster, but since 1-2 years I
> have the
> > feeling 1) that it is getting too fast and 2) that
> I'm not the only
> > one saying this
> 
> If it's "getting too fast", then that's
> fine, some people are not
> comfortable with rapid change.  Other operating systems
> change much
> slower, perhaps one of them would work out better.
> 
> But right now, the Linux kernel is moving very rapidly. 
> Like it has for
> the past 5 years (I have the numbers to back that up...)

I have the problem since 2.6.20

> 
> Remember, we are changing for real reasons, who is to tell
> a devloper
> that the reason for a change is not allowed just because we
> want to slow
> down?  Does that not make their need somehow less than
> someone elses?

This is not the issue - the original point was to reconsider your understanding what is old in terms of kernel from the user point of view

> 
> We change because the world changes.  In order to survive,
> we also need
> to change.
> 
> If we stop, we die.

This is true, but out of scope - see above. There is no sence to install a new kernel that does not support my hardware and also is outaged when I have the drivers for this kernel version.

> 
> > > Applications are a different story, they should
> "just work" with
> > > different kernel versions, there should not be
> any problems there.
> > > If there are, let the kernel developers know, we
> take backwards
> > > userspace compatiblity VERY seriously.
> > 
> > gcc-4.3 ;-) is it application or what do you mean ...
> the compiler is
> > not an application ;-)
> 
> gcc 4.3 runs just fine on 2.6.22.  It's the fact that
> you want to _use_
> gcc 4.3 to build 2.6.22 that is an issue.  They are two
> totally
> different things here.

Yes I've got your point, you are right. It's producing crap ;-)

>From the user point of view something works if it produces something useful - until then it's not working. 


thank you for the discussion I hope it brings something useful at the end.
I've been using linux since 1999 so I think I have the right feeling in what I need and what I say, though I'm not that close to the kernel dev as you are, as I'm working if different field, so I hope nobody is insulted and I'm trying to put forward a messages and find some useful solution. 

> 
> thanks,

Thank you too

> 
> greg k-h
> --
> To unsubscribe from this list: send the line
> "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
