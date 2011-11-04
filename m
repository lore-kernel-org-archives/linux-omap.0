From: Michael Opdenacker <michael.opdenacker@linaro.org>
Subject: Re: [PATCH 1/1] arm: omap: removed obsolete IRQF_DISABLED
Date: Fri, 04 Nov 2011 10:10:06 -0400
Message-ID: <4EB3F23E.3060009@linaro.org>
References: <1318139198-6865-1-git-send-email-michael.opdenacker@linaro.org> <1318139198-6865-2-git-send-email-michael.opdenacker@linaro.org> <20111103221501.GD31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44496 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab1KDOKK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 10:10:10 -0400
In-Reply-To: <20111103221501.GD31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@ti.com, linux@arm.linux.org.uk, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 11/03/2011 06:15 PM, Tony Lindgren wrote:
> * Michael Opdenacker <michael.opdenacker@linaro.org> [111008 22:13]:
>> This flag is a NOOP since 2.6.36
> Looks like there's an ARM wide patch to do this with
> "[PATCH 03/55] arm: irq: Remove IRQF_DISABLED".
Good. Let's take this one then. I hadn't gone through all the sub
maintainers yet.

Thanks for your reply,

Cheers,

Michael.

-- 
Michael Opdenacker - Community Manager
Linaro, http://linaro.org
Phone: +33 484 253 396
IRC: 'opm' in #linaro on irc.freenode.net

