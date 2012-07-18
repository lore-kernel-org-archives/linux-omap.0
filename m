From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
Date: Wed, 18 Jul 2012 21:47:05 +0530
Message-ID: <CAMQu2gygvOeWrOPBnc=21oTPWWnFG8go5gcxAJ5UfDTG+cPRLw@mail.gmail.com>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <20120622123013.GA7586@sirena.org.uk> <20120622131750.GB19226@n2100.arm.linux.org.uk>
 <20120622161155.GM4037@opensource.wolfsonmicro.com> <20120625111847.GE19226@n2100.arm.linux.org.uk>
 <20120627114003.GG308@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:52530 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171Ab2GRQR2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 12:17:28 -0400
Received: by vcbfy27 with SMTP id fy27so3032304vcb.9
        for <linux-omap@vger.kernel.org>; Wed, 18 Jul 2012 09:17:25 -0700 (PDT)
In-Reply-To: <20120627114003.GG308@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

+ Peter,

On Wed, Jun 27, 2012 at 5:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 25, 2012 at 12:18:47PM +0100, Russell King - ARM Linux wrote:
>
>> It appears to be something to do with the jack detection that's going wrong.
>> If I start the audio with the jack disconnected, I never get anything out
>> of the board.  It requires the jack to be connected before the first use.
>> The on-board speakers used to work without the jack plugged in at one time
>> but they seem to be completely non-functional now.
>
>> Confused.
>
> Me too - there's nothing obvious in the code just from inspection that
> would affect this.

Does audio work with $subject series after your mux fixes which
you posted recently.

Regards
Santosh
