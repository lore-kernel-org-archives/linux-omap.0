From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Re-add a lost TSC2102 touchscreen Kconfig entry
Date: Tue, 22 May 2007 16:40:50 -0700
Message-ID: <200705221640.51098.david-b@pacbell.net>
References: <fb249edb0705221022s5bec31d4r77bfc16373262b4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0705221022s5bec31d4r77bfc16373262b4e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 22 May 2007, andrzej zaborowski wrote:
> The TSC2102 option in drivers/input/touchscreen/Kconfig got lost
> somewhere in January (although the commit is not visible in git-web),
> so adding it back. 

I noticed that ... by the way, it looked to me like it should be
very possible to make this TSC2102 touchscreen code work on the
TSC2101 too.  I think someone should

  - Make such a common touchscreen core (maybe there's stuff to
    be borrowed from the tsc2301 touchscreen too, but not all
    the relevant page 1 registers are the same on tsc2301).

  - Move more of the IRQ handling logic from tsc2102.c into the
    shared touchscreen code ... have it manage irqs etc, it can
    get the number from a platform_device resource as usual.

  - Have proper hwmon support for the other ADC devices on the
    two chips (battery, aux, and temp sensors ... the chips have
    different numbers of each).

    Looks tricky to safely split touchscreen ADC client code
    from the hwmon sensors, so I'd suggest keeping it together
    in one module.  (That's what ads7846 does, FWIW.)

Looks to me like other than the audio support (which should also
probably convert to use the new sound/soc/* framework), large parts
of the tsc2101 and tsc2102 drivers should be identical.  There
are a few bits that would need to have "switch(chiptype){...}",
but core code can -- should! -- be the same.

- Dave
