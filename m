From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH Resend] ARM: OMAP2+: Remove empty io.h
Date: Wed, 16 Nov 2011 16:11:50 -0800
Message-ID: <87d3cr620p.fsf@ti.com>
References: <1321459012-15418-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321459012-15418-1-git-send-email-weber@corscience.de> (Thomas
	Weber's message of "Wed, 16 Nov 2011 16:56:52 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: tony@atomide.com, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Thomas Weber <weber@corscience.de> writes:

> The file arch/arm/mach-omap2/io.h is empty, so we can remove it.
>
> Signed-off-by: Thomas Weber <weber@corscience.de>

It's empty and unused elsewhere.

Acked-by: Kevin Hilman <khilman@ti.com>
