From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Sat, 25 Jun 2011 20:09:22 +0100
Message-ID: <20110625190922.GA7736@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com> <20110624140142.GM9449@n2100.arm.linux.org.uk> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com> <20110624141402.GN9449@n2100.arm.linux.org.uk> <20110624151201.GO9449@n2100.arm.linux.org.uk> <4E04DBF8.1050401@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54469 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab1FYTJe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 15:09:34 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

On Sun, Jun 26, 2011 at 12:23:31AM +0530, Premi, Sanjeev wrote:
> [sp] I thought we were solving a problem - but this makes it
>      look like race for addding sign-offs - which I am not
>      interested in.

No, it's called packaging the patch up and getting it ready, putting it
out on the list for people to test and provide Tested-by's, acked-by's
etc.

Would you rather people sat on fixes doing nothing with them for a
month instead, watching broken -rc after broken -rc going by?
