From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/2] Trace: PM: promote event 'power_domain_target' to generic power domains.
Date: Wed, 14 Oct 2015 18:49:11 +0200
Message-ID: <5770595.eudVgXqToR@vostro.rjw.lan>
References: <1443429864-4177-2-git-send-email-mtitinger+renesas@baylibre.com> <1842060.xHgP7up4AJ@vostro.rjw.lan> <561E0FD3.6010809@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <561E0FD3.6010809@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, ahaslam@baylibre.com
List-Id: linux-omap@vger.kernel.org

On Wednesday, October 14, 2015 10:18:27 AM Marc Titinger wrote:
> On 14/10/2015 02:55, Rafael J. Wysocki wrote:
> > On Monday, September 28, 2015 03:20:44 PM Marc Titinger wrote:
> >> - change arg3 to a state name string: we got the current CPU rom the trace
> >> backend already. This also prepares for multiple/named states in the power
> >> domain, consistent with idle-states. states in the domain may match given
> >> CPU states in this case, we will trace them by their name, and potentially
> >> use arg2 as a link to their index for the cpuidle driver.
> >>
> >> - tested with Juno DP
> >>
> >> <idle>-0     [000]    42.395510: power_domain_target:  a53_pd index=0 'cluster-sleep-0'
> >> <idle>-0     [000]    42.395528: cpu_idle:             state=4294967295 cpu_id=0
> >> <idle>-0     [000]    42.395668: cpu_idle:             state=2 cpu_id=0
> >>
> >> - compiled for Omap2+
> >>
> >> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> >
> > Hi,
> >
> > What's your intent regarding this series?  Do you want it to be applied
> > separately, or is it going to be part of a larger series?
> 
> Hi Rafael,
> 
> v3 is a missed attempt to rebase this on the current head, but I did not 
> fix v3 because thinking twice it's not that useful until Axel Haslam's 
> multiple genpd states stuff is merged in. I'm finding v2 useful, shall I 
> re-post v2 as v4 for clarity then ?

That's up to you mostly.

If I get ACKs from all of the appropriate people on those, I can easily apply them.

Thanks,
Rafael

