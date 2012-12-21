From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/9] drivers: mailbox: framework creation
Date: Fri, 21 Dec 2012 09:31:57 +0200
Message-ID: <CAK=Wgba=jLiig+TBcAcp7STz=Y6RM8noR_0S2HZjNQXLZV8JBA@mail.gmail.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <CACRpkdaqO7AAeYeR8SZt4Tbv1grrMq85TNYMc-FSbUSrnZBm=Q@mail.gmail.com>
 <20121220182835.GB21056@atomide.com> <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Loic Pallardy <loic.pallardy-ext@stericsson.com>, arm@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.co>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 20, 2012 at 9:19 PM, Olof Johansson <olof@lixom.net> wrote:
> While we can make the branch stable, would it make sense to make
> remoteproc for omap depend on !multiplatform during the transition, to
> reduce dependencies a little? Either way works, but it'd be nice to
> keep them independent if we can.

I'm not sure multiplatform is the culprit; OMAP's remoteproc driver
heavily depends on this mailbox code, and obviously breaks with this
patch-set if only for the the naming changes. We'll need this patch
set to update omap's remoteproc as well so at least we don't break
bisectibility, though running a sanity test before merging would be
even nicer (Loic I can help if you don't have a panda board).

BTW - grep shows that tidspbridge is using the mailbox code too, but
it's in staging and I'm not sure it gets much love. Nevertheless, as
long as it's there we should at least update it with the new API as
well.

Thanks,
Ohad.
