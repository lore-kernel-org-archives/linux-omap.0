From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 1/2] mailbox: OMAP: introduce mailbox framework
Date: Mon, 05 Nov 2012 20:40:18 -0700
Message-ID: <509886A2.5060509@wwwdotorg.org>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org> <1352170552-29564-2-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352170552-29564-2-git-send-email-omar.luna@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Linus Walleij <linus.walleij@linaro.org>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/05/2012 07:55 PM, Omar Ramirez Luna wrote:
> Actually moving it from plat-omap, as this framework/driver code is
> supposed to be under drivers/ folder. The framework should work with
> the current supported OMAP processors (OMAP1+) that have mailbox and
> can be used as a method of interprocessor communication.
> 
> The mailbox hardware (in OMAP) uses a queued mailbox-interrupt mechanism
> that provides a communication channel between processors through a set of
> registers and their associated interrupt signals by sending and receiving
> messages.

> diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h

Is this a public interface to the driver? If so, shouldn't the header be
in include/linux somewhere?

Is this a generic interface to any mailbox driver? If so, then I don't
think having "omap" in the symbol names is appropriate. If the header is
specific to the OMAP driver, I don't think using the very generic
filename "mailbox.h" is appropriate; use omap_mailbox.h instead?
