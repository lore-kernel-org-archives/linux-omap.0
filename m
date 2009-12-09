From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] [I2C-OMAP] Add support for 16-bit registers
Date: Tue, 8 Dec 2009 16:58:56 -0800
Message-ID: <6cb013310912081658y636b2215k8df12c8a98b5e0c@mail.gmail.com>
References: <1260083648-13051-1-git-send-email-darkstar6262@gmail.com>
	<20091209002914.GB32202@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091209002914.GB32202-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 8, 2009 at 4:29 PM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
>
> how about changing the read and write register calls to do the
> necessary address munging so you don't have to change all the
> callsites throughout the file?
>

Huh, yeah, that would be smarter.  I'll do that and resubmit.

Thanks
- Cory
