From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: USB driver issue
Date: Sun, 3 Aug 2008 03:17:03 +0300
Message-ID: <20080803001702.GC23361@frodo>
References: <367F0428-0D27-41F0-9C60-F3821B6C2CD2@student.utwente.nl> <54651.89695.qm@web53208.mail.re2.yahoo.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54651.89695.qm-9wxuV4rZ2daB9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Stalin Kenny <stalinlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Koen Kooi <k.kooi-oe7qfRrRQfcdWmXj+hCI//P6llvjuJOh@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 02, 2008 at 04:45:19PM -0700, Emanoil Kotsev wrote:
> I don't mind testing for you for free, but I need for few reasons something relaible. If you can not make it to offer such a kernel version then admit it and stop writing things that are insulting to hear.

Did you really had a big break with linux since 2.6.20 ??

> I'm using linux because I like the open source philosophy and I contribute to it for free, also because I like it so. If you are trying to earn money or to force me to pay for a support (like Novel/SuSE suggests) then forget it. We all contribute to this philosophy for free and that's why you have so much to do.

And we're gonna still doing it for free. Whenever I leave work, my
company is not paying me anymore. Even the work I have for publishing
stuff, my company is not paying me for. The hours I spent listening and
helping out, the way I can, the community my company is not paying me
for.

> What we would like to see is something between "latest" and "such old" kernel that has fewer bugs, so I may not go to bed and think about if my data is there tomorrow or not. And with the changes you make and go forward without (I repeat) without excessive testing. You can not guarantee this!

And once again you're mistaken. Just to be sure, I've been testing musb
driver (the original bug report was to musb) for over 20 hours and got
no problems so far. And, believe me, there people crazier than me about
stress testing ;-)

> I just wanted to share an experience or impression I have since 2.6.20 and this impression is getting worse the way you think and put forward things.

As Greg said, this model has been working quite well so far and it
doesn't seem we're gonna change it.

> I just wanted to give you an advanced user opinion and to find out what could be done.
> Well, so far nothing and the only solution for me is to stick to my tested 2.4.26 kernel and wait that better times come and something changes in the  kernel development community. Neither 2.6.20 nor 2.6.24 are running wihtout a problem and believe me I'm not testing 2.6.26 FOR FREE on my server where I've stored my data. 

Why don't you file bugs then? The thing is that we really can't stop
moving forward to check something over 1 year old. We have so many
changes from version to version that it's impossible to go 4 versions
back on time and check what's wrong there.

If you have any coding skills, you can provide support for older
versions of the kernel if you feel like, but like Greg said, it's hell a
of work to do.

The 2.6.xx release cycle has been quite stable so far. One thing we do
care is not to break something that was working before - don't reply with
closed source drivers arguments, please; there's nothing we can do about
them - sometimes we have a regression and something gets messed, sorry.
We also commit mistakes. But generaly, things are going quite good. The
fix for that regression will most likely be applied to one of the
-stable team releases.

If you really DO need a stable older version kernel, you can stick with
the pre-compiled images coming from your distro. They are supported and
somewhat frozen. Once in a while you'll get an update for that
particular version.

Saying that neither 2.6.20 nor 2.6.24 are running without a problem is
both vague and true. True because every sw has problems, so has linux
kernel. Vague because you're not telling us where are the problems ?!?

I'm using 2.6.27-rc1 and it has been quite a long time (and I've been
using 2.6 series since 2.6.0) that I don't have big issues with it.
Suspend-to-ram and suspend-to-disk are working just fine, acpi is quite
good (thanks to Arjan and the other people in linux-acpi), usb is also
really good (we have an uncountable number of working drivers), wifi is
working, bluetooth is working, anyways, I really don't have problems
with linux.

ps: only while I was writing this mail I pulled 185 new changes from
linux-2.6.git, not counting merges.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
