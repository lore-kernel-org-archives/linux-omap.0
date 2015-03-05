From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: reboot command fails with low frequency
Date: Thu, 5 Mar 2015 10:23:16 +0100
Message-ID: <CAOf5uwkWvd_gH08t-AacU8Jp4gFmr4X42bMv4eT43Uhaaa5GMQ@mail.gmail.com>
References: <CAJ2oMhLDbA_BVsZPnbNq460mYbUw6Z7QpB=YmSCjX65NL1BaFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAJ2oMhLDbA_BVsZPnbNq460mYbUw6Z7QpB=YmSCjX65NL1BaFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Thu, Mar 5, 2015 at 9:46 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>> I added power support to kernel menuconfig, such as cpuidle, and it
>> seems to work fine. I also validated in counter that cpu gets into
>> retention.
>
> We observer that with highest available frequency (600000) reboot
> command is OK, but when frequency is changed to lower value, the
> reboot command fails.
> Has anyone observed such behaviour ?

I remember some commit for this problem. What version of the linux are
you running?

Michael

>
> Regards,
> Ran
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
