From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH] Input: gpio-keys: Support for one-directional interrupts
Date: Wed, 09 Dec 2009 12:32:20 +0100
Message-ID: <87fx7kgz7f.fsf@tac.ki.iif.hu>
References: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com> (Cory
	Maccarrone's message of "Sat, 5 Dec 2009 14:38:14 -0800")
Sender: linux-input-owner@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Cory Maccarrone <darkstar6262@gmail.com> writes:

> The current gpio-keys driver assumes that each given GPIO has
> the ability to respond to both rising and falling interrupts
> at the same time.  For some GPIOs on certain devices, the interrupt
> is only one-directional -- either rising or falling, depending on
> what's being listened for.  In particular, the HTC Herald keyboard
> slide switch interrupt must be switched from rising to falling and
> back on each event, otherwise only one transition will be detected.

Interesting.  Btw. I'd like to convert gpio-keys from edge-triggered to
level-triggered interrupts.  Would that work for your hardware?
-- 
Regards,
Feri.
