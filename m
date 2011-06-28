From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 23:55:23 +0100
Message-ID: <20110628225523.GA23312@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com> <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40629 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1F1Wzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 18:55:37 -0400
Content-Disposition: inline
In-Reply-To: <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Jun 28, 2011 at 03:29:57PM -0700, Colin Cross wrote:
> Can't this rewrite the loops_per_jiffy for the other CPU while it is
> in a udelay?  If it has already calculated the number of loops
> necessary, and the CPU frequency increases, it could end up returning
> too early from udelay.

udelay uses the global loops_per_jiffy.
