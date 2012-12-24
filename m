From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/9] drivers: mailbox: framework creation
Date: Mon, 24 Dec 2012 17:17:30 +0200
Message-ID: <CAK=WgbaJCwF+vg+23mH7wjyUnVMYjFvpK_Wbffk3SEXKTB-1MA@mail.gmail.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <CACRpkdaqO7AAeYeR8SZt4Tbv1grrMq85TNYMc-FSbUSrnZBm=Q@mail.gmail.com>
 <20121220182835.GB21056@atomide.com> <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
 <CAK=Wgba=jLiig+TBcAcp7STz=Y6RM8noR_0S2HZjNQXLZV8JBA@mail.gmail.com>
 <50D42337.3080204@st.com> <CAJ6Av5N+H4eno+9FizLp9gNsZrZ-TQnLnVGjf-UMBtNiDVuNdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ6Av5N+H4eno+9FizLp9gNsZrZ-TQnLnVGjf-UMBtNiDVuNdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: Loic PALLARDY <loic.pallardy@st.com>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Loic PALLARDY STE <loic.pallardy-ext@stericsson.com>, "arm@kernel.org" <arm@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linu>
List-Id: linux-omap@vger.kernel.org

Hi Omar,

On Fri, Dec 21, 2012 at 9:33 PM, Omar Ramirez Luna
<omar.ramirez@copitl.com> wrote:
> Yes, I made the changes, for tidspbridge and remoteproc, I will submit
> both for review, based on this series.

Great, thanks.

Please note that when we do eventually merge this, we need your
updates to be squashed into Loic's patches so we don't break
bisectibility.

Thanks,
Ohad.
