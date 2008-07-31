From: Emanoil Kotsev <deloptes@yahoo.com>
Subject: Re: USB driver issue
Date: Thu, 31 Jul 2008 13:38:59 -0700 (PDT)
Message-ID: <368260.89826.qm@web53203.mail.re2.yahoo.com>
References: <20080731163634.GA9606@kroah.com>
Reply-To: deloptes@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web53203.mail.re2.yahoo.com ([206.190.49.73]:46174 "HELO
	web53203.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754335AbYGaUjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jul 2008 16:39:00 -0400
In-Reply-To: <20080731163634.GA9606@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vge>

Thanks for having your attention.

--- On Thu, 7/31/08, Greg KH <greg@kroah.com> wrote:

> From: Greg KH <greg@kroah.com>
> Subject: Re: USB driver issue
> To: "Emanoil Kotsev" <deloptes@yahoo.com>
> Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "SUBHRANIL CHOUDHURY" <subhra85@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
> Date: Thursday, July 31, 2008, 6:36 PM
> On Thu, Jul 31, 2008 at 08:30:26AM -0700, Emanoil Kotsev
> wrote:
> > I think everything is getting pretty messy recently -
> I was pretty
> > satisfied with 2.6.20 and then tried 2.6.24. In fact I
> can not compile
> > 2.6.20 right now because after an upgrade debian
> testing comes with
> > gcc-4.3 that has a background struggle about who's
> wrong between gcc
> > people and Linus Torvalds and the issue is still open.
> 
> That's an issue between you and Debian, just downgrade
> your version of
> gcc if you don't like this.  Or use a distro that
> allows multiple
> versions of gcc to be installed at the same time (I
> trivially switch
> between 4 versions of gcc on my box.)

You are right, and it was ment as an example of inconvenience what happens in developers world and the user (me) is suffering after all.
I personally have other solution for the issue. Using debian testing for a while was just a test.

> 
> Either way, it's not a kernel issue, how could you
> blame 2.6.20 for gcc
> 4.3 issues when gcc 4.3 was not even released when .20 was
> released?
> Are us kernel people time travellers?

:-) good point. Everytime I switch to a new kernel I have to download a bunch of different versions of drivers and software and compile them, install them and test them and end up with a bunch of new bugs. I don't have the time recently to play this nasty game and I'm getting tired
Why should I do this? I just want to fix problems in current kernel that I'm using.
I would agree with you if new versions do not come with new bugs, but they do, thus my suggestion.

> 
> > So what I'm pleading for is to focus on stability!
> 
> What exactly do you propose for such a "focus"? 
> How do you see this
> happening?

Kernel developers should fix bugs in minor kernel versions as they are meant for this purpous and do major changes only in major version. A bunch of bugfixes I see (not only usb related) are just not in place in minor kernel versions. That's my opinion at first place.

Second if you want to have me as happy linux user developers should agree to support older versions to help embeded and other developers working further on their projects.
And I'm writing this because (also in other forums) people tend to have such a neglecting mentality ignoring the needs of others. Just to remember the reason for this discussion was the statement that 2.6.22 was too old, which as Anand pointed out was in it's latest release was issued in the beginning of the year. This is really "windows like"  mentality and as Anand says at least they support the versions they issue - sorry for this - but I think it's kind of truth.

> 
> > And yes I'm planing to try 2.6.26, but I'm
> pretty sure that there
> > would be issues with drivers like uvcview, the
> proprietary ATI and
> > NVidia and apps like skype
> 
> Closed source drivers have issues, film at 11.  Bah, take
> it up with
> them, there is NOTHING that us developers can do about
> that, sorry.

You are neglecting the point and kind of insulting me! So you think I should spent my time convincing about 20 people from different companies to recompile their software because I was told by you to upgrade to fix a usb issue or a kind that is not related to their software and when they finally do it there is a already a new kernel version ... sorry I can not agree with any of you on this point. You want me to spent my time contacting people and not working on my projects ;-)

Why just not be able to patch my old kernel without breaking the ability to use the software I already have installed and is working with the version I use?

I think this is the question no body wants to answer and I think there is a problem with you guys. What are you doing this development if some people are not happy with it and have reasonable arguments.

May be the patches should be split into smaller files related to bugs - just an idea!
You experience a bug and patch - the bug is gone you are happy.
May be there should be some longer period to support at least the latest stable releases ... but something should be done.
I know the Linus policy conserning 2.6. tree has changed for the reason to let us improve faster, but since 1-2 years I have the feeling 1) that it is getting too fast and 2) that I'm not the only one saying this

> 
> Applications are a different story, they should "just
> work" with
> different kernel versions, there should not be any problems
> there.  If
> there are, let the kernel developers know, we take
> backwards userspace
> compatiblity VERY seriously.

gcc-4.3 ;-) is it application or what do you mean ... the compiler is not an application ;-)

thanks for helping me to catch up with the developers opinion. I'm honest about this really

kind regards

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


      
