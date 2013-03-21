From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv3 00/14] drivers: mailbox: framework creation
Date: Thu, 21 Mar 2013 12:39:49 +0100
Message-ID: <CACRpkdYpJLdTx_sVyLj+MVzXqcyfucyP8qy_b_8jiArU+NSMfQ@mail.gmail.com>
References: <1363145021-14339-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363145021-14339-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Ohad Ben-Cohen <ohad@wizery.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic Pallardy <loic.pallardy@st.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 13, 2013 at 4:23 AM, Suman Anna <s-anna@ti.com> wrote:

> Please find the updated mailbox patch series for pulling into linux-next.
> The series is rebased on top of 3.9-rc2, and includes one new patch to
> rename an existing mailbox.h added as part of the highbank cpufreq
> support for 3.9 merge window [1].

ARM SoC folks:

would you consider pulling this stuff into the ARM SoC tree?

It turns out that ux500 multiplatform support is sort of relying
on this refactoring since it helps us to break apart the huge
PRCMU driver.

I am proceeding with my multiplatform work but things like
this not being upstream will make the patches look ugly
and I cannot quite consider it properly done before this is
fixed too.

Yours,
Linus Walleij
