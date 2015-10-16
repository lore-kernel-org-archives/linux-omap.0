From: Tyler Baker <tyler.baker@linaro.org>
Subject: Re: [PATCH v2 0/3] ARM: handle imprecise aborts from firmware in
 common code
Date: Fri, 16 Oct 2015 12:11:53 -0700
Message-ID: <CANMBJr5DdOOa7EMCxCAowNVFaw2wYvXHZTDgmWJP5bM2hgsbmA@mail.gmail.com>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Hauke Mehrtens <hauke@hauke-m.de>, patchwork-lst@pengutronix.de, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Lucas,

On 15 October 2015 at 03:32, Lucas Stach <l.stach@pengutronix.de> wrote:
> This series implements the handling of a pending imprecise abort left behind
> by the bootloader/firmware running before Linux in the common ARM startup code.
>
> It turns pending imprecise aborts that may signal during the first unmasking
> of such aborts on the boot CPU into a non-faulting event and warns the user
> that the firmware of the machine might be buggy.
>
> Handling this in the common code makes sure that we only ignore already pending
> aborts and not those that may happen later during system boot/usage. It also
> allows to remove the custom fault handler from the 3 architectures that are
> known to have bad firmware/bootloaders.
>
> V2 adapts patch 1 to suggestions from Russell and Hauke and drops former
> patch 3 (ARM: mvebu: remove the workaround imprecise abort fault handler)
> as it has already been applied.

I have build and boot tested the three patches in this series on top
of next-20151016 with the kernelci.org system[1][2]. It found no new
build/boot regressions and also I can confirm it fixes the issue
reported here[3].

Tested-by: Tyler Baker <tyler.baker@linaro.org>

Cheers,

Tyler

[1] http://kernelci.org/boot/all/job/tbaker/kernel/v4.3-rc5-8587-g6890e51b69b2/
[2] http://kernelci.org/build/tbaker/kernel/v4.3-rc5-8587-g6890e51b69b2/
[3] http://www.spinics.net/lists/arm-kernel/msg451280.html
