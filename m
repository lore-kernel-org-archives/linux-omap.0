From: Greg KH <gregkh@suse.de>
Subject: Re: Interrupt issue in twl4030_keypad
Date: Mon, 12 Dec 2011 11:23:09 -0800
Message-ID: <20111212192309.GA12889@suse.de>
References: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, stable@vger.kernel.org, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 12, 2011 at 08:30:49PM +0200, Felipe Contreras wrote:
> Hi,
> 
> The short version is this: either we revert this patch[1], or we apply
> this patch series[2], as well as its essential fixes[3].
> 
> The long version is this. There's a synchronization issue with the
> current keypad driver and twl core; the irq is marked as handled even
> though the thread that is supposed to handle it hasn't run yet, and
> since it's clear-on-read, and it hasn't been read, it's detected
> again, so they keypad driver receives two interrupt callbacks instead
> of one, and in the second one reads nothing from the i2c register, so
> a key release is assumed. This makes key-presses as simple as shift+a
> impossible.
> 
> In other words, it's totally unreliable. This might not be isolated to
> the keypard driver, but other "nested" interrupts from twl core that
> started using request_threaded_irq prematurely (before it was
> supported by the twl core). But at least I haven't tried those.
> 
> This patch was applied on 2.6.33, which means all versions before 3.2
> are affected, including 3.1.
> 
> What do you think about fixing this on stable kernels?

I think you need to tell me exactly what git commit ids in Linus's tree
that you want to see in the stable kernel releases, which you didn't do
here :(

Also, please use stable@vger.kernel.org, stable@kernel.org has been dead
since August.

thanks,

greg k-h
