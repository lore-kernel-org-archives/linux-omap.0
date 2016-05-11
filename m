From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/10] Get MUSB PM runtime working again
Date: Wed, 11 May 2016 16:03:29 -0700
Message-ID: <20160511230329.GN5995@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
 <5725A31D.8020508@gmail.com>
 <20160503162528.GM5995@atomide.com>
 <5728E334.3090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5728E334.3090000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160503 10:46]:
> On  3.05.2016 19:25, Tony Lindgren wrote:
> >* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160430 23:34]:
> >>
> >>Unfortunately that makes my n900 unbootable with USB cable detached, see the
> >>attached file (at [  152.121673]) when there is USB cable. I guess we're
> >>missing a couple of pm_runtime_get()/put() calls.
> >
> >OK so it seems. I did some brief testing with n900 too, but never
> >hit this so far. Care to email me the kernel .config you're using
> >so I can try to reproduce it here?
> >
> 
> .config is attached. There is stuff in it still to be upstreamed, just
> ignore it :). Or, you may pull
> https://github.com/freemangordon/linux-n900/commits/v4.6-rc4-n900-camera,
> apply the $subject series on top of it and build rx51_defconfig. There
> shouldn't be any patches touching USB.
> 
> Does bqXXX and isp1707_charger modules got loaded when you tested it? Or
> those were built-in? or not built at all? As it seems the problem arises
> when those try to touch USB ULPI.

OK managed to track this issue down. It's related to built-in musb
where a -EPROBE_DEFER causes musb to reinit. And then PM runtime got
confused about the musb glue layer parent use count. And then doing
a modprobe isp1704_charger caused a problem with the ulpi read/write.

Will repost the whole series after some more testing and clean-up.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
