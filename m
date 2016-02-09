From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
Date: Tue, 9 Feb 2016 09:18:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602090917040.2906@utopia.booyaka.com>
References: <1455008743-21660-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455008743-21660-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 9 Feb 2016, Kishon Vijay Abraham I wrote:

> OCP2SCP doesn't support smart idle wakeup according to
> Table 26-22. OCP2SCP_SYSCONFIG in AM572x TRM [1] and
> Table 26-22. OCP2SCP_SYSCONFIG in AM571x TRM [2].
> Remove SIDLE_SMART_WKUP from the list of supported SIDLE modes
> in hwmod data.
> 
> [1] -> http://www.ti.com/lit/ug/spruhz6e/spruhz6e.pdf
> [2] -> http://www.ti.com/lit/ug/spruhz7a/spruhz7a.pdf
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks, queued for v4.6.  If you'd like it queued as a fix, please resend 
with a description of the regression that it fixes.


- Paul
