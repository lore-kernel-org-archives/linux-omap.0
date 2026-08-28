Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FA233939;
	Fri, 28 Aug 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927035; cv=none; b=fiyMW36ufmNkj4UGUQUY/QtwyGUqAfngCrnQ3HPKgMwlXGOa4bmZZDyYinbQncXuomZRBJgmhYzGpwFfCMltUxqjNmUx6aiH3hcVSfRxIygRv+NuDZ4rVu/mZjm+94RqNN/73JCmRrnoRWDd63K8xCXEElMb+9AhXXQTVWtHR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927035; c=relaxed/simple;
	bh=CjXBZ8CW9jS9Si/hU3wLLJz6vVfW1vbfyNUmsNGS2i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjWw4FiC+bwX4tdzWumpG08QDebuzhZl4SUJw3gYr+lU5pxXhyc5Pi1+hFlpl0YSxonfZ+SOfkAPFBhnalJfK3Q0OGvUq8dAU4SKM5HnDboFE5BD8xJPnMxPj4Q6W4li8Q9rcOzC2Bma4yygDpF3e8gEprQXkH8etett4Uu1nVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=LHebnPYy; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="LHebnPYy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=6phfOWLFdcwVnYF12rPCHS2viJVLOqHNfc3nToPxDvo=; t=1787927033; x=1789136633; 
	b=LHebnPYyaobPhf4B+8bqJVqVKn+Yv7smU3FuxlbzvGDbWJH3grNsiZkkC48HwdIBBL97w8uG+x0
	7md9DFbxTLgbNTl/vmkh8Y3WtVvSz69mBDf2sr1T3FddhQJp6lBtPWNLu9s/5hgvz3L0tAWeII2gZ
	5SxrDk+fCBOoXSaw0ZV0F8MBYiRzYKky7oMZNkwRDbvnD3qTe6H7riDjwZzvkouDc03cBJ/AiBpd6
	aNIizAGTSc64wJaPgjmkxXR5Q0uZDYa2Ah0Dr0QcUhposK0C14bTi4/yDibjakgma2EB+L9221Ixj
	LUfjb/xolZRcGfrr19gbKbN0cDcBmAizCnZw==;
Date: Fri, 28 Aug 2026 15:43:37 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tony
 Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org
Subject: Re: [REGRESSION] OpenPandora (OMAP3) fails to boot since v7.2-rc1,
 bisected to b8eeeca5545659
Message-ID: <20260828153902.49aa3772@kemnade.info>
In-Reply-To: <2013A99A-0502-4128-ACFA-B04886224393@goldelico.com>
References: <2013A99A-0502-4128-ACFA-B04886224393@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 14:49:54 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi,
> I am seeing a boot regression on OpenPandora (OMAP3) since v7.2-rc1.
> 
> A git bisect identified:
> 
> b8eeeca5545659 ("clocksource/drivers/timer-ti-dm: Add clocksource support")
> 
> as the first bad commit.
> 
> Reverting this commit restores normal boot operation.
> 
> The regression is fully reproducible:
> * v7.1: boots normally
> * v7.2-rc1 and later: hangs during early boot after about 3 seconds
>   after reporting
> [    3.631072] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps every 65535999984741ns
> [    3.643341] clocksource: omap_dm_timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
> [    3.660430] clocksource: Switched to clocksource omap_dm_timer
> * v7.2-rc1 + revert of b8eeeca5545659: boots normally again
> 
Same on GTA04, also OMAP3. I have seen some OMAP4 fully booting with v7.2.

> What caught my attention is that OMAP already has an existing DMTimer
> clocksource implementation in timer-ti-dm-systimer.c, introduced by:
> 
> 52762fbd1c4778 ("Add support for using the TI Dual-Mode Timer as a clocksource")
> 
> while b8eeeca5545659 adds another clocksource implementation to
> timer-ti-dm.c.
> 
> The commit message and patch series state that the driver automatically
> selects the first timer marked with the "ti,timer-alwon" DT property and
> registers it as a clocksource/sched_clock.
> 
> I have not determined the failure mechanism, but the bisect result and
> successful revert strongly suggest that the new DMTimer clocksource path
> conflicts with the existing OMAP3 timer setup.
> 
> Therefore, I would like to ask:
> * Is the new timer-ti-dm clocksource intended to coexist with the
>   existing timer-ti-dm-systimer clocksource implementation on OMAP3?

Why a new second ti-dm-clocksource is introduced at all?

> * Is b8eeeca5545659 expected to be active on OMAP3 systems?
> * Has this combination been tested on OMAP3 hardware?
> * What is the solution?
> 
I would suggest, reverting that offending commit together with adding
missing pieces to timer-ti-dm-systimer.c

Regards,
Andreas
