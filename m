From: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix OOPS in omap_i2c_unidle() during probe
Date: Tue, 11 May 2010 10:19:09 +0300
Message-ID: <20100511101909.9ab45b8a.jhnikula@gmail.com>
References: <1269339176-17479-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<alpine.DEB.2.00.1003310427180.14436@utopia.booyaka.com>
	<20100331152700.17695375.jhnikula@gmail.com>
	<n2m6ed0b2681004160247o7cddd774sd199ea0eb51c9946@mail.gmail.com>
	<20100511095407.cb44ef8d.jhnikula@gmail.com>
	<20100511070122.GE11783@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100511070122.GE11783-etG4378wJBqLa08RA6KHbYwBHEhOmDVPtqGf+n4yE6E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <ext-mika.1.westerberg-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 11 May 2010 10:01:22 +0300
Mika Westerberg <ext-mika.1.westerberg-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:

> I believe this is already in mainline:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7c6bd2010fced38444c9fd658f4c6ce61bd185bf
> 
Ah, yeah. I was using the sound-2.6.git tree which is not yet updated
any newer than 2.6.34-rc4 and that's why I didn't see it. Sorry about
line noise.


-- 
Jarkko
