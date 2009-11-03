From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: Re: [PATCH v2] TWL4030: Initial support for TWL5031
Date: Tue, 3 Nov 2009 13:29:49 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0911031243210.14058@tumpelo.ntc.nokia.com>
References: <1255702360-2143-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752229AbZKCLbe@vger.kernel.org>
In-Reply-To: <1255702360-2143-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Hi Samuel,

On Fri, 16 Oct 2009, Koskinen Ilkka (Nokia-D/Tampere) wrote:
> TWL5031 introduces two new interrupts in PIH. Moreover, BCI
> has changed remarkably and, thus, it's disabled when TWL5031
> is in use.
>
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> ---
> drivers/mfd/twl4030-core.c  |   12 ++++-
> drivers/mfd/twl4030-irq.c   |  127 +++++++++++++++++++++++++++++++++++++++++--
> include/linux/i2c/twl4030.h |   47 ++++++++++++++--
> 3 files changed, 173 insertions(+), 13 deletions(-)

Sorry to bothering you again, but I'd like to know the status
of this patch. Does it need more work or could you apply it
to your tree at some point?

Cheers, Ilkka
