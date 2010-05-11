From: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix OOPS in omap_i2c_unidle() during probe
Date: Tue, 11 May 2010 09:54:07 +0300
Message-ID: <20100511095407.cb44ef8d.jhnikula@gmail.com>
References: <1269339176-17479-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<alpine.DEB.2.00.1003310427180.14436@utopia.booyaka.com>
	<20100331152700.17695375.jhnikula@gmail.com>
	<n2m6ed0b2681004160247o7cddd774sd199ea0eb51c9946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <n2m6ed0b2681004160247o7cddd774sd199ea0eb51c9946-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <ext-mika.1.westerberg-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 16 Apr 2010 12:47:50 +0300
Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> >> Tested-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Uhm why does this patch (or Tony's version) doesn't reach mainline for
> so long? It's critical for all OMAPs except the very old ones.
> 
> If it helps:
> Tested-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> > Tested-by: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Ping? Mike or Tony, can you resend the patch just in case.

Reminder: 2.6.34 doesn't boot on OMAP without this patch.


-- 
Jarkko
