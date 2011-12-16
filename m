From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Interrupt issue in twl4030_keypad
Date: Fri, 16 Dec 2011 03:36:08 +0200
Message-ID: <CAMP44s3u61qgqLXz4t8rSZAkZoqp06Uu6eo6cikLiY3vS=urfQ@mail.gmail.com>
References: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
	<20111212191241.GC3408@legolas.emea.dhcp.ti.com>
	<CAMP44s1X_KDbzu2CLO0fzM=7rozTQ4K10AtQkc0Ww8uDg8Z-mw@mail.gmail.com>
	<20111212213359.GB4349@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20111212213359.GB4349@legolas.emea.dhcp.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 12, 2011 at 11:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Dec 12, 2011 at 10:55:11PM +0200, Felipe Contreras wrote:
>> > Samuel assumed it was ok and, like I said above, it worked for my simple GPIO
>> > usecase with beagleboard.
>>
>> Well, for 3.2 I think the situation is fine, but that's not what I'm
>> talking about. About your GPIO tests, are you sure you got the
>> interrupts through twl4030 irq handling?
>
> Card detect GPIO on beagleboard is a TWL GPIO. Checking that
> removing/adding the card actually triggers an IRQ, should be enough. No?

Perhaps the reason that worked is because
drivers/mmc/host/omap_hsmmc.c is not requesting a threaded IRQ, so the
action handler was able to run while in handle_twl4030_pih() was still
running (handle_nested_irq), but everything else that was using
request_threaded_irq() didn't have an action handler, but a
thread_fn(), so they were scheduled to run after handle_twl4030_pih().

That's also why you didn't notice the endless loop while pressing a key.

The lesson to learn from this is; don't mix threaded and non-threaded
irq handling.

-- 
Felipe Contreras
