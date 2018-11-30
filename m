From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/3] mach-omap2: handle autoidle denial
Date: Thu, 29 Nov 2018 23:57:45 -0800
Message-ID: <154356466554.88331.3614998218425782290@swboyd.mtv.corp.google.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <154353757335.88331.5161306764126530976@swboyd.mtv.corp.google.com>
 <6c450d4f-8dbf-5122-edcc-3ac17e295bbe@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6c450d4f-8dbf-5122-edcc-3ac17e295bbe@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2018-11-29 23:37:35)
> On 30/11/2018 02:26, Stephen Boyd wrote:
> > Quoting Andreas Kemnade (2018-11-10 12:31:12)
> >> On the gta04 with a dm3730 omap_hdq does not work properly when the
> >> device enters lower power states. Idling uart1 and 2 is enough
> >> to show up that problem, if there are no other things enabled.
> >> Further research reveals that hdq iclk must not be turned off during
> >> transfers, also according to the TRM. That fact is also correctly desc=
ribed
> >> in the flags but the code to handle that is incomplete.
> >>
> >> To handle multiple users of a single ick, autoidle is disabled
> >> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
> >>
> >> Changes since v1:
> >> - uses spinlocks instead of mutexes
> >> - invert counter logic
> >> - check whether clock type is basic
> >>
> > =

> > I'm expecting someone like Tero or Tony to review this.
> > =

> =

> Rest of it looks fine to me, except for the discussion under the =

> CLK_IS_BASIC flag, which might trigger a bigger rework of the code.
> =


Is that a Reviewed-by tag?
