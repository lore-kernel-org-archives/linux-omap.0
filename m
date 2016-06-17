From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap1: fix ams-delta FIQ handler to work with
 sparse IRQ
Date: Fri, 17 Jun 2016 02:39:45 -0700
Message-ID: <20160617093944.GB22406@atomide.com>
References: <1466106990-9556-1-git-send-email-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466106990-9556-1-git-send-email-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [160616 13:00]:
> After OMAP1 IRQ definitions have been changed by commit 685e2d08c54b
> ("ARM: OMAP1: Change interrupt numbering for sparse IRQ") introduced
> in v4.2, ams-delta FIQ handler which depends on them no longer works
> as expected. Fix it.

Applying into omap-for-v4.7/fixes thanks. Good to hear you got it
working, I recall being a bit worried about what all I might break
with the sparse IRQ conversion.. Sorry about that.

Regards,

Tony
