From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys: Support for one-directional interrupts
Date: Wed, 9 Dec 2009 08:15:26 -0800
Message-ID: <6cb013310912090815u396fd84chfab3c7bf4d5f4bc9@mail.gmail.com>
References: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com>
	<87fx7kgz7f.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <87fx7kgz7f.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 9, 2009 at 3:32 AM, Ferenc Wagner <wferi@niif.hu> wrote:
> Cory Maccarrone <darkstar6262@gmail.com> writes:
>
> Interesting. =C2=A0Btw. I'd like to convert gpio-keys from edge-trigg=
ered to
> level-triggered interrupts. =C2=A0Would that work for your hardware?

I'm fairly certain it wouldn't.  Each of the interrupts on my hardware
has a corresponding bit in a control register that determines if it's
rising or falling-edge triggered -- thus the need for my patch.  To
capture both directions, it's necessary to modify the control register
when a falling edge is detected, so that the corresponding rising edge
can be collected afterward.  May I ask why you're thinking of
converting to level-triggering?

Perhaps it would be better to provide an option in the platform_device
structure to set edge- or level-triggering, similar to the change I'm
proposing for interrupts that can only signal one way at a time.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
