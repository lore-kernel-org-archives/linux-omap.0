From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Wed, 6 Jun 2012 18:33:31 +0100
Message-ID: <20120606173331.GB19478@mudshark.cambridge.arm.com>
References: <4FC7B465.60703@ti.com>
 <87r4u0ytd9.fsf@ti.com>
 <4FC7E161.1080400@ti.com>
 <87d35kyo3v.fsf@ti.com>
 <4FC7F87C.9080709@ti.com>
 <87obp3vptz.fsf@ti.com>
 <4FC8D4F0.6040806@ti.com>
 <20120602164228.GA14903@mudshark.cambridge.arm.com>
 <4FCD2C30.8000106@ti.com>
 <4FCE0746.2090505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49637 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755253Ab2FFRdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 13:33:45 -0400
Content-Disposition: inline
In-Reply-To: <4FCE0746.2090505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Jun 05, 2012 at 02:19:02PM +0100, Jon Hunter wrote:
> Hi Will,

Hi Jon,

> On 06/04/2012 04:44 PM, Jon Hunter wrote:
> Anyway, let me know what you think of this approach. An alternative is
> to put the calls pm_runtime_get/put outside of the reserve/release_pmu,
> which would be a simpler change, but I was thinking that the above maybe
> more aligned with your thinking.

Ok, thanks for this. Whilst your code is definitely more like I'm
envisaging, you're right about the churn and until I've sorted out the
reservation code so that it's a callback via the PMU structure, it is
overly messy.

So for the time being let's do what you suggested and put the suspend/resume
calls into armpmu_{reserve,release}_hardware. We can still kill the irq
enable/disable calls and I can rework this slightly when I change the
reservation code.

Cheers,

Will
