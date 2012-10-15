From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Mon, 15 Oct 2012 15:41:56 +0530
Message-ID: <CAM=Q2cuJ-0VSgkBme_Cg8YD2cBG5NZcO6aBeTsPZ_PQGMwJ=bw@mail.gmail.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	<87ipag90om.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
	<87d30n7o9q.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C8C9F@DNCE04.ent.ti.com>
	<1350282068.17145.42.camel@kj-X230>
	<1350292602.17145.63.camel@kj-X230>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350292602.17145.63.camel@kj-X230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Cc: "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "Kankroliwala, Huzefa" <huzefank-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 15, 2012 at 2:46 PM, Kalle Jokiniemi
<kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org> wrote:
> ma, 2012-10-15 kello 09:21 +0300, Kalle Jokiniemi kirjoitti:
>> Hi,
>>
>> pe, 2012-10-12 kello 14:46 +0000, Strashko, Grygorii kirjoitti:
>> > Hi Kevin,
>> >
>> > yep, [1] is the same fix - thanks.
>> >
>> > Hi Kalle,
>> >
>> > i've applied these changes and PM runtime fix on top of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git (omap2plus_defconfig)
>> > Could you check it with your use case, pls? (just to be sure that idea is right)
>>
>> Odd, it's not working. I'll add some debug prints to see what happens
>> there.
>
> Well, seems after enabling irq 23 in the resume_noirq, someone does
> i2c_xfer and there is consequent flood of i2c_xfers and interrupts.
If there is continuous xfers, you could enable debug LL and see who is
queuing the
transfers.

>
> Not sure now how these IRQ numbers get mapped these days, my debug print
> says it's irq number 72 (UART1 from TRM) that is flooding (although it's
> printed from the i2c-omap isr function, so it's still I2C bus irq...).

Can you do a cat /proc/interrupts


>
> The irq enabling (in resume_noirq) is still slightly progressing after
> the flooding starts, but my watchdog kicks in before we get to the
> finish.
>
> Attached my debug prints patch and log. I used also "no_console_suspend"
> boot option.
>
> - Kalle
>
