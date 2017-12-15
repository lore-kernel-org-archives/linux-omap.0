From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] arm: dts: Remove leading 0x and 0s from bindings notation
Date: Fri, 15 Dec 2017 13:41:30 +0100
Message-ID: <CAJKOXPecm-e7P6uFvdDCBimcFbvATpf5pfJyzLXgKdTwFDPEJQ@mail.gmail.com>
References: <20171214165350.27850-1-malat@debian.org> <CAJKOXPeLiPfoUfpPU-sAAOuD057kTzRE-g4bFq4afFOOtRRZOg@mail.gmail.com>
 <CA+7wUsz9FO5ytY3a6RONu+kGm1NKjK8z378UzxjUWmk2tBhi7A@mail.gmail.com> <CA+7wUsxMdukt2hu+HKua-C5OwSY-yexVgGnkq071yC5A6XX-_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+7wUsxMdukt2hu+HKua-C5OwSY-yexVgGnkq071yC5A6XX-_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mathieu Malaterre <malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>, Niklas Cassel <niklas.cassel-VrBV9hrLPhE@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Sascha Hauer <ker>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 15, 2017 at 1:18 PM, Mathieu Malaterre <malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> wrote:
>> As discussed with Krzysztof, I've split the ARM patch into subarch.
>> Please drop this one.
>
> Hum...looks like my internet provider just blacklisted me for too many
> recipient in the mail. I'll do my best to resolve this, and send the
> rest of the  series.

You can fix this by:
1. sending each mail separately (some for-do loop in bash with 'git
send-email --cc-cmd "scripts/get_maintainer.pl --no-git --no-roles
--no-rolestats --no-git-fallback"') because these are really
independent patches,
2. create a cover letter sent to everyone but send particular commits
only to respective folks:
a. get list of cc for cover letter:
scripts/get_maintainer.pl --no-multiline --interactive --separator=\''
--to '\' --no-git --no-roles --no-rolestats --no-git-fallback 00*
b. send patches (except cover letter now):
git send-email --cc-cmd "scripts/get_maintainer.pl --no-git --no-roles
--no-rolestats --no-git-fallback" --to linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
--no-thread --in-reply-to='<COVER_LETER_THREAD_ID>' 000[1-9]-*
00[1-9]*-*

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
