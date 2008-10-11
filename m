From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Fri, 10 Oct 2008 17:32:30 -0700
Message-ID: <200810101732.31094.david-b@pacbell.net>
References: <20081010120427.GZ3044@atomide.com> <200810101554.34176.david-b@pacbell.net> <FCCFB4CDC6E5564B9182F639FC3560870239624A4A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:25383 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754060AbYJKAcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 20:32:32 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870239624A4A@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Friday 10 October 2008, Pandita, Vikram wrote:
> Somewhere for the T2 interrupts following function has to be run:=20
> =A0=A0=A0=A0=A0=A0=A0=A0set_irq_flags(i, IRQF_VALID);

Why do you think that's not being done?

On Beagle, it's clearly done.  And the init sequence is
the same on Overo.  So I see no reason to think it's not
being done there too...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
