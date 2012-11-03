From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 09/15] ARM: OMAP: AM33XX: Remove unnecessary include and
 use __ASSEMBLER__ macros
Date: Sat, 3 Nov 2012 21:59:55 +0530
Message-ID: <50954683.4050302@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-10-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36196 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756915Ab2KCQaN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 3 Nov 2012 12:30:13 -0400
In-Reply-To: <1351859566-24818-10-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> Get rid of some unnecessary header file inclusions
> and also use __ASSEMBLER__ macros to allow the
> various register offsets from PM assembly code
> which be added in a subsequent patch.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Ideally you should split header clean-up and assembler
fix in seperate patches.

Regards
Santosh

