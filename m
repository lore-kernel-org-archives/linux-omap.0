From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/9] mailbox: rename omap_mbox in mailbox
Date: Thu, 20 Dec 2012 23:29:59 +0200
Message-ID: <CAK=WgbYOJA26PU7sg0ndB981WQEeiaQxSUVEJRACw1b7ogpiOg@mail.gmail.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-4-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355836212-17956-4-git-send-email-loic.pallardy-ext@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Linus Walleij <linus.walleij@linaro.org>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-omap@vger.kernel.org

Hi Loic,

On Tue, Dec 18, 2012 at 3:10 PM, Loic Pallardy
<loic.pallardy-ext@stericsson.com> wrote:
> In order to create a generic mailbox framework, functions
> and structures should be renamed in mailbox.

This patch should also update omap_remoteproc.c so the build doesn't
break (and if you have a panda board around it might be nice to run
the remoteproc sample to make sure things still generally work).

Thanks,
Ohad.
