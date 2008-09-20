From: David Brownell <david-b@pacbell.net>
Subject: Re: MUSB not workin in .27rc6, was: Re: OMAP support in mainline?
Date: Fri, 19 Sep 2008 17:49:00 -0700
Message-ID: <200809191749.00327.david-b@pacbell.net>
References: <87tzcgi1gv.fsf@nokia.com> <20080918095537.GD28615@gandalf.research.nokia.com> <615FFFC3-999C-4DBD-A0FE-DCAA8BF18429@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:28118 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752785AbYITAtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 20:49:03 -0400
In-Reply-To: <615FFFC3-999C-4DBD-A0FE-DCAA8BF18429@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Friday 19 September 2008, Koen Kooi wrote:
> Ok, another datapoint: client mode (tested on beagle by M=E5ns) and h=
ost =A0
> mode (tested on overo by Steve) work with a similar patch as above, =A0
> OTG mode is broken (tested on beagle and evm by me).

one issue being that TWL4030 irqs don't cause the OTG state machine
to change from the "Default_B" side to the "Default_A" side ... that
is, ID sense isn't operational.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
