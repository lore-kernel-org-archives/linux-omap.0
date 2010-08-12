From: Gregory CLEMENT <gclement00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] Put OMAP2 SPI CS in unactive
	state when return from suspend
Date: Thu, 12 Aug 2010 10:43:36 +0200
Message-ID: <AANLkTik7O1s-UAt0abyJoakSSjHGJD6CSktOD+O=BGou@mail.gmail.com>
References: <AANLkTin7-ZqFRH4GXT4aUfQ4sE=8Jc=3i0j8rTH7EyBm@mail.gmail.com>
	<871va52ent.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <871va52ent.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/8/11 Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

> Gregory CLEMENT <gclement00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>
> > We notice that when system wake up from OFF mode, then CS is in
> > unactive state until the first SPI transfert.
> > For our design it lead to some conflict on this I/O.
> > Unactive state for CS when there is no transfert shoudl be the correct
> > behaviour: this is the purpose of these patches.
>
> This approach handles an off-mode transition during suspend, but if
> off-mode is enabled, you can also have an off-mode transition during
> idle.
>
>
Well maybe I didn't use the correct words.
During the system life, I monitored the CS behaviour using a oscilloscope.
I also activate debug in omap2_mcspi, so I see when driver disable the
clocks and restore context when device is not used.
Each time the CS is in the correct state. It is only when there is a suspend
with the following configuration that on resume the CS is in wrong state( ie
activated)


echo 1 > /mnt/pm_debug/enable_off_mode
echo 0 > /mnt/pm_debug/core_pwrdm/suspend
echo 1 > /mnt/pm_debug/voltage_off_while_idle



> Since you didn't describe what the conflicts you're seeing are, I would
> assume that you'll have the same problems in idle as in suspend, and
> this series doesn't address the idle case.
>

I didn't see any problem in idle case, just when system resume from a
suspend to ram (echo mem > /sys/power/state)


>
> Kevin
>
>
>
> > Gregory CLEMENT (2):
> >   spi: Add hook on suspend/resume for spi master
> >   spi/omap2_mcspi: When SPI wake up from OFF mode, CS is in wrong
> >     state: force it to unactive state
> >
> >  drivers/spi/omap2_mcspi.c |   11 ++++++++++-
> >  drivers/spi/spi.c         |   15 ++++++++++++++-
> >  include/linux/spi/spi.h   |    4 +++-
> >  3 files changed, 27 insertions(+), 3 deletions(-)
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Gregory CLEMENT
------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
