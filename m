From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 23:41:23 +0530
Message-ID: <CAM=Q2csQ7dVWUi2vrRMCQ653t_GxtXqH2yGMjY9YAkvA+_i9WA@mail.gmail.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	<87ipag90om.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
	<87d30n7o9q.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C8C9F@DNCE04.ent.ti.com>
	<87r4p363ps.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r4p363ps.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "Kankroliwala, Huzefa" <huzefank-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 12, 2012 at 10:13 PM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
> "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>
>> Hi Kevin,
>>
>> yep, [1] is the same fix - thanks.
>
>> Hi Kalle,
>>
>> i've applied these changes and PM runtime fix on top of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git (omap2plus_defconfig)
>> Could you check it with your use case, pls? (just to be sure that idea is right)
>
> I think the ideas is right, but [1] introduces more potential problems
> since it disables the IRQ at the INTC well before being disabled at the
> device.
I fail to see this point. Current driver supports master mode only.
So unless there is a msg queued by the core. May be no interrupts should fire.

what I mean

msg -> conf -> intr -> completion/error  -> autosuspend.

>  With runtime PM autosuspend timeouts, that means any IRQs
> firing during the autosuspend delay will be lost, which basically
> nullifies the use of autosuspend.

so I do not expect any interrupts between completion/error -> autosuspend.

>
> Since Shubhrajyoti didn't respond to my runtime PM comments on the
> original patch,

my apologies for the delay.

> I'll respin this patch by moving the INTC disable/enable
> into the runtime PM callbacks and make the changelog a bit more clear.
>
> Grygorii, that pm_runtime_resume() change is needed to.  Can you spin a
> patch with just that change with a nice descriptive changelog about why
> it is needed?  Thanks.
>
> Kevin
