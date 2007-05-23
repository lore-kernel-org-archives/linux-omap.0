From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] Re-add a lost TSC2102 touchscreen Kconfig entry
Date: Thu, 24 May 2007 01:54:10 +0200
Message-ID: <fb249edb0705231654u5c7b0e66pb8d1be0c57f86e36@mail.gmail.com>
References: <fb249edb0705221022s5bec31d4r77bfc16373262b4e@mail.gmail.com>
	<200705221640.51098.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200705221640.51098.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 23/05/07, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 22 May 2007, andrzej zaborowski wrote:
> > The TSC2102 option in drivers/input/touchscreen/Kconfig got lost
> > somewhere in January (although the commit is not visible in git-web),
> > so adding it back.
>
> I noticed that ... by the way, it looked to me like it should be
> very possible to make this TSC2102 touchscreen code work on the
> TSC2101 too.  I think someone should
>
>   - Make such a common touchscreen core (maybe there's stuff to
>     be borrowed from the tsc2301 touchscreen too, but not all
>     the relevant page 1 registers are the same on tsc2301).
>
>   - Move more of the IRQ handling logic from tsc2102.c into the
>     shared touchscreen code ... have it manage irqs etc, it can
>     get the number from a platform_device resource as usual.

I would insist on keeping all direct register access in a single file
- it makes life a lot easier. The register access functions alone can
be split out easily though.

>
>   - Have proper hwmon support for the other ADC devices on the
>     two chips (battery, aux, and temp sensors ... the chips have
>     different numbers of each).

This part shouldn't be difficult.

>
>     Looks tricky to safely split touchscreen ADC client code
>     from the hwmon sensors, so I'd suggest keeping it together
>     in one module.  (That's what ads7846 does, FWIW.)

Right, so optimally I'd have all tsc210x_read/write calls in only one
file (e.g. tsc210x.c) and that would be the same file that handles the
IRQ. tsc2102_ts.c doesn't have any 2102 specific code and can be
reused also for 2301.

>
> Looks to me like other than the audio support (which should also
> probably convert to use the new sound/soc/* framework), large parts

Converting to ASoC was precisely what I intended to try doing
yesterday but I hit my MMC/SD not working and with no UART or network
on my board I'm going to come back to this some other day.

Regards,
Andrzej
