From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 19:02:04 +0100
Message-ID: <20100526190204.5efe4d59@lxorguk.ukuu.org.uk>
References: <20100526171106.0e44a736@schatten.dmk.lab>
	<alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

> The power efficiency of a mobile device is depending on a sane overall
> software stack and not on the ability to mitigate crappy software in
> some obscure way which is prone to malfunction and disappoint users.

Even if you believe the kernel should be containing junk the model that
works and is used for everything else is resource management. Not giving
various tasks the ability to override rules, otherwise you end up needing
suspend blocker blockers next week.

A model based on the idea that a task can set its desired wakeup
behaviour *subject to hard limits* (ie soft/hard process wakeup) works
both for the sane system where its elegantly managing hard RT, and for
the crud where you sandbox it to stop it making a nasty mess.

Do we even need a syscall or will adding RLIMIT_WAKEUP or similar do the
trick ?

Alan
