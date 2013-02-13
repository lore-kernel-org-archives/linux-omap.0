From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 00/13] drivers: mailbox: framework creation
Date: Wed, 13 Feb 2013 14:36:32 +0100
Message-ID: <CACRpkdZayg-X11ZRnh2Z0i+egBn8Fhwya-6_Yr8wcv+6s0CVqQ@mail.gmail.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Greg Kroah-Hartman <greg@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Loic Pallardy <loic.pallardy@st.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, Omar Ramirez Luna <omar.luna@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 12, 2013 at 5:56 AM, Suman Anna <s-anna@ti.com> wrote:

> I have hosted the series at [3].
> [3] https://github.com/sumananna/mailbox/commits/dbx500-prcmu-mailbox

Suman, I suggest you ask Stepgen Rothwell to include this
branch into the linux-next tree, so we can get some
rotation of this stuff in preparation for the v3.10 merge
window. (It's not going in now anyway.)

If it proves to survive some smoke testing there, I suggest
we proceed to pull this into the ARM SoC tree early in
the v3.10 kernel cycle, since all the dependencies will be
in ARM SoC anyway.

Yours,
Linus Walleij
