From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 0/5] PM / clock_ops: provide default runtime ops and cleanup users
Date: Tue, 21 Apr 2015 11:04:57 +0200
Message-ID: <CAMuHMdXEe4pPDVAimKH3ThJYee_JF35pyOfKzjMamPkJDfTj6w@mail.gmail.com>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
	<7hfv7ue68c.fsf@deeprootsystems.com>
	<55358AE5.1070900@oracle.com>
	<CAMuHMdX3-Ces57VcpyXEJBSUB07ZtpcCiN8ZpiStGcQnDEHt4A@mail.gmail.com>
	<775b18eaf35d4319ae4762098e558d1b.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <775b18eaf35d4319ae4762098e558d1b.squirrel@www.codeaurora.org>
Sender: linux-sh-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 21, 2015 at 10:56 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> Note that the new code always has a dev_pm_domain, while the old code had
>> it
>> conditionally on CONFIG_PM.
>
> Right, but since USE_PM_CLK_RUNTIME_OPS is actually a nop with
> !CONFIG_PM, we don't really need the checks anymore.

What I mean is that it uses more memory, to store the dev_pm_domain struct.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
