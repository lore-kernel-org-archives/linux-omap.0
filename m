From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] touchscreen: ads7846: please don't touch free'd memory
Date: Tue, 25 May 2010 17:56:27 -0400
Message-ID: <AANLkTik72Q50eHX5cLW4uZ13BiMVCKQ0_bKdrCGZxpeE@mail.gmail.com>
References: <1274226413-8520-1-git-send-email-khilman@deeprootsystems.com>
	<20100519000019.GA17475@core.coreip.homeip.net> <87mxvnlpxv.fsf@deeprootsystems.com>
	<20100525202135.GC4455@core.coreip.homeip.net> <8739xflkn5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <8739xflkn5.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Michael Roth <mroth@nessie.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 25, 2010 at 17:46, Kevin Hilman wrote:
> After digging into the driver core and realizing that it seemed to
> have sane error handling itself, I took a closer look at
> ads7846_probe() and discovered it doesn't actually return an error
> code for certain failure cases! =C2=A0That was the root cause.

that is crappy

> Subject: [PATCH] input: touchscreen: ads7846: return error on probe f=
ailure

i'd refer to the specific probe issue rather than just "probe".  maybe:
input: touchscreen: ads7846: return error on regulator_get() failure

otherwise:
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
