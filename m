From: "Stalin Kenny" <stalinlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB driver issue
Date: Thu, 31 Jul 2008 19:47:07 -0500
Message-ID: <8cef9d540807311747k614eba83p5a783960c7613ec8@mail.gmail.com>
References: <20080731163634.GA9606@kroah.com>
	 <368260.89826.qm@web53203.mail.re2.yahoo.com>
	 <20080731210245.GA9789@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080731210245.GA9789@frodo>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe,

Sorry to say but to say that one has to migrate to latest kernel in
order to get community support is not right....the statement does has
a touch of arrogance. You are not the spokeperson for the community.


On Thu, Jul 31, 2008 at 4:02 PM, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote:
> Hi,
>
> I hope we end this thread some day...
>
> On Thu, Jul 31, 2008 at 01:38:59PM -0700, Emanoil Kotsev wrote:
>> Kernel developers should fix bugs in minor kernel versions as they are meant for this purpous and do major changes only in major version. A bunch of bugfixes I see (not only usb related) are just not in place in minor kernel versions. That's my opinion at first place.
>>
>> Second if you want to have me as happy linux user developers should agree to support older versions to help embeded and other developers working further on their projects.
>> And I'm writing this because (also in other forums) people tend to have such a neglecting mentality ignoring the needs of others. Just to remember the reason for this discussion was the statement that 2.6.22 was too old, which as Anand pointed out was in it's latest release was issued in the beginning of the year. This is really "windows like"  mentality and as Anand says at least they support the versions they issue - sorry for this - but I think it's kind of truth.
>>
>
> 2.6.22 was in Jul 2007, he pointed out a minor stable version out of
> 2.6.22.
>
>> > > And yes I'm planing to try 2.6.26, but I'm
>> > pretty sure that there
>> > > would be issues with drivers like uvcview, the
>> > proprietary ATI and
>> > > NVidia and apps like skype
>> >
>> > Closed source drivers have issues, film at 11.  Bah, take
>> > it up with
>> > them, there is NOTHING that us developers can do about
>> > that, sorry.
>>
>> You are neglecting the point and kind of insulting me! So you think I should spent my time convincing about 20 people from different companies to recompile their software because I was told by you to upgrade to fix a usb issue or a kind that is not related to their software and when they finally do it there is a already a new kernel version ... sorry I can not agree with any of you on this point. You want me to spent my time contacting people and not working on my projects ;-)
>
> You are really missing the whole point of the discussion.
>
> The driver in question is musb, which is not closed source at all.
> Closed source drivers is a different issue and Linux kernel is said that
> won't provide a stable API. It's always changing.
>
> Really, musb driver _has_ changed since 2.6.22 and that special 2.6.22
> version was coming from a vendor we cannot support vendor kernel. We
> support linux mainline git tree, that's all.
>
> I just asked why using that version, I didn't ask nobody to upgrade. But
> really, all the changes made from 2.6.22 until now would make any musb
> patch from 2.6.22 to be unaplicable to recent musb code, besides,
> *again* it might be that the particular bug could have been fixed in all
> those set of changes in musb driver from 2.6.22 until now, so why
> spending time trying to fix again something that might have been fixed ?
> We could only backport that particular bug fix to 2.6.22.
>
>> Why just not be able to patch my old kernel without breaking the ability to use the software I already have installed and is working with the version I use?
>
> You can do it, but you cannot expect that your patch get accepted, it
> might even not apply and that was my point.
>
>> I think this is the question no body wants to answer and I think there is a problem with you guys. What are you doing this development if some people are not happy with it and have reasonable arguments.
>
> Talk for yourself, don't "broadcast" it.
>
>> May be the patches should be split into smaller files related to bugs - just an idea!
>> You experience a bug and patch - the bug is gone you are happy.
>> May be there should be some longer period to support at least the latest stable releases ... but something should be done.
>
> If the api has changed you cannot expect that. Specialy if you're using
> vendor-specific kernel, it doesn't matter if it's nokia, redhat, ubuntu,
> TI, etc.
>
>> > Applications are a different story, they should "just
>> > work" with
>> > different kernel versions, there should not be any problems
>> > there.  If
>> > there are, let the kernel developers know, we take
>> > backwards userspace
>> > compatiblity VERY seriously.
>>
>> gcc-4.3 ;-) is it application or what do you mean ... the compiler is not an application ;-)
>
> And it works it doesn't matter the kernel is running below it. If it can
> generate good binaries or not it's a different story. Has nothing to do
> with kernel, it's a gcc-related issue, don't you think ?
>
> Anyways, this thread is already way too big.
>
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
