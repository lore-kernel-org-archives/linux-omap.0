From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] reboot: Backup orderly_poweroff
Date: Thu, 14 Jan 2016 13:25:27 +0000
Message-ID: <20160114132527.575e0f20@lxorguk.ukuu.org.uk>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
	<20160114090520.GA4351@gmail.com>
	<569767EC.2010704@ti.com>
	<20160114100913.GB15857@gmail.com>
	<56977BA7.702@ti.com>
	<20160114112354.GA17869@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160114112354.GA17869@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Keerthy <a0393675@ti.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, edubezval@gmail.com, grygorii.strashko@ti.com, nm@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, joel@jms.id.au, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, dyoung@redhat.com, josh@joshtriplett.org, mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org

> 
> If kernel_power_off() is called then the system should power off. No ifs and 
> whens.

Even if it doesn't the watchdog should kill it. 

That is broken on some platforms on the watchdog side as the
watchdog shuts down during our power off callbacks - because the system
firmware is too stupid to reset the watchdog as it powers back up (so
keeps rebooting).

If you watchdog and firmware function properly you shouldn't even have to
care if you crash during the kernel power off.

Alan
