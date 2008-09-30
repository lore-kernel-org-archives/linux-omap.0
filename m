From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 04/25] i2c: move twl4030_keypad to new style registration
Date: Tue, 30 Sep 2008 14:42:47 -0700
Message-ID: <200809301442.48086.david-b@pacbell.net>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com> <1222800189-29737-4-git-send-email-me@felipebalbi.com> <1222800189-29737-5-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:29350 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752018AbYI3VpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 17:45:22 -0400
In-Reply-To: <1222800189-29737-5-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Tuesday 30 September 2008, Felipe Balbi wrote:
> +struct twl4030_keypad_data {
> +=A0=A0=A0=A0=A0=A0=A0int rows;
> +=A0=A0=A0=A0=A0=A0=A0int cols;
> +=A0=A0=A0=A0=A0=A0=A0int *keymap;
> +=A0=A0=A0=A0=A0=A0=A0int irq;
> +=A0=A0=A0=A0=A0=A0=A0unsigned int keymapsize;
> +=A0=A0=A0=A0=A0=A0=A0unsigned int rep:1;
> +};

To fix later:  "irq" should be a standard platform resource.

Those references in board init code to TWL4030_MODIRQ_KEYPAD
should vanish, and add_children() should just pass the right
number the standard way.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
