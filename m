From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Thu, 11 Oct 2012 13:29:11 +0530
Message-ID: <CAM=Q2cuAMNMR5PGZR98OEYWMUrXXxyWXYg4d=3CPAFEv+cWXfg@mail.gmail.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349871480-25182-1-git-send-email-kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 10, 2012 at 5:48 PM, Kalle Jokiniemi
<kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org> wrote:
> The resume_noirq enables interrupts one-by-one starting from
> first one. Now if the wake up event for suspend came from i2c
> device, the i2c bus irq gets enabled before the threaded
> i2c device irq, causing a flood of i2c bus interrupts as the
> threaded irq that should clear the event is not enabled yet.
>
> Fixed the issue by adding suspend_noirq and resume_early
> functions that keep i2c bus interrupts disabled until
> resume_noirq has run completely.
>
> Issue was detected doing a wake up from autosleep with
> twl4030 power key on N9. Patch tested on N9.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>

Thanks for rebasing however since you were actually interested in one
of the older
stable releases how about cc stable?
