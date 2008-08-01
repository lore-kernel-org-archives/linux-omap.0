From: Daniel Stone <daniel.stone-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB driver issue
Date: Fri, 1 Aug 2008 16:05:09 +0300
Message-ID: <20080801130509.GY25065@intune.research.nokia.com>
References: <20080731163634.GA9606@kroah.com> <368260.89826.qm@web53203.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <368260.89826.qm-ddnbr+Bmt6iB9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 31, 2008 at 01:38:59PM -0700, ext Emanoil Kotsev wrote:
> Kernel developers should fix bugs in minor kernel versions as they are meant for this purpous and do major changes only in major version. A bunch of bugfixes I see (not only usb related) are just not in place in minor kernel versions. That's my opinion at first place.

Except that the code has often changed as a result of these major
changes, and not everyone wants to track everything that happens in two
branches.  You said it yourself: you don't want to go to the effort of
tracking one major branch.  So why are you trying to force developers to
track two?

> Second if you want to have me as happy linux user developers should agree to support older versions to help embeded and other developers working further on their projects.

That's unbelievably selfish and insulting.  'This free operating system
you gave me is shit! You need to change the entire way you develop for
my benefit!'

No, sorry.

If you want to support older versions, then no-one's stopping you.
Hell, there's still a 2.0 maintainer.  No-one's forcing them to move up
to new versions.

> > Closed source drivers have issues, film at 11.  Bah, take
> > it up with
> > them, there is NOTHING that us developers can do about
> > that, sorry.
> 
> You are neglecting the point and kind of insulting me! So you think I should spent my time convincing about 20 people from different companies to recompile their software because I was told by you to upgrade to fix a usb issue or a kind that is not related to their software and when they finally do it there is a already a new kernel version ... sorry I can not agree with any of you on this point. You want me to spent my time contacting people and not working on my projects ;-)

You said it yourself -- you object to kernel developers, who have given
you a free kernel, telling you how to spend your time.  Yet you have the
right to tell the kernel developers how to spend _their_ time, including
supporting closed-source drivers, which basically amounts to reverse
engineering?

Have you any idea how unbelievably rude this is?

> Why just not be able to patch my old kernel without breaking the ability to use the software I already have installed and is working with the version I use?

If you want, you can follow the development tree and backport the
patches to the last stable version.  No-one's trying to stop you.

> I think this is the question no body wants to answer and I think there is a problem with you guys. What are you doing this development if some people are not happy with it and have reasonable arguments.

I think there's a problem with your attitude, and a pretty serious one
at that.

Open source development generally happens because people enjoy doing it.
If you think they're doing it wrong, do it your way.  I was up until
5:30am last night writing code, and was rewarded with a splitting
headache.  If you think you have a better way to do it and the others
disagree, well, it's up to you to just put in and do it.

Think that's hard? Have other things to do? Well yes, it is hard, and
yes, we all have other things to do.  Now you understand why you
attempting to force people to change the way they work is disrespectful
and insulting, I hope.

> May be the patches should be split into smaller files related to bugs - just an idea!

They are.

> You experience a bug and patch - the bug is gone you are happy.
> May be there should be some longer period to support at least the latest stable releases ... but something should be done.
> I know the Linus policy conserning 2.6. tree has changed for the reason to let us improve faster, but since 1-2 years I have the feeling 1) that it is getting too fast and 2) that I'm not the only one saying this

Okay, so put your money where your mouth is.  Contribute.

Until I see patches (instead of mails telling us how hard your life is
because you don't have the time to test one kernel version, but kernel
developers should all spend the time to test two or more) from you, I
have nothing more to say to you.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
