From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
	use ldrex/strex
Date: Mon, 24 Jan 2011 15:00:48 +0000
Message-ID: <20110124150048.GC22949@n2100.arm.linux.org.uk>
References: <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk> <20110123001636.GA20841@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101222323190.8580@xanadu.home> <20110123093526.GA26120@n2100.arm.linux.org.uk> <AANLkTi=tpnNXm8w9-VFi72nYvXRQV5-jE7Qn9NNk1wLW@mail.gmail.com> <AANLkTinnQLsa4mOV+SLYxeRrwZdc8N36SW9pK6ne+6TQ@mail.gmail.com> <20110124102849.GA18459@n2100.arm.linux.org.uk> <AANLkTikmwDkdiAPoCx+Oz7qhTbpuOTHeam9gSi=WesSa@mail.gmail.com> <20110124141112.GM16202@n2100.arm.linux.org.uk> <AANLkTimz1YcJ=Me5ZmiwnHcOoa18X-NajX6PQy_g3UH8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44554 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab1AXPBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 10:01:01 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimz1YcJ=Me5ZmiwnHcOoa18X-NajX6PQy_g3UH8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 08:24:41PM +0530, Poddar, Sourav wrote:
> nfs filesystem.

Thanks.
