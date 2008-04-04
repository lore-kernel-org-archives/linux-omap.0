From: David Brownell <david-b@pacbell.net>
Subject: Re: Idle picture for those interested.
Date: Fri, 4 Apr 2008 13:56:40 -0700
Message-ID: <200804041356.40567.david-b@pacbell.net>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903F14825@dlee13.ent.ti.com> <3B6D69C3A9EBCA4BA5DA60D91302742903F14855@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:37538 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751073AbYDDU4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 16:56:42 -0400
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903F14855@dlee13.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org

On Friday 04 April 2008, Woodruff, Richard wrote:
> For any interested I'm posting a small snippet of what an ARM-OMAP id=
le
> looks like. =A0Having a nice tool can go a long ways. =A0I'm not sure=
 if the
> picture will make it, but it's worth a try. =A0Knowing what is out th=
ere
> for tools is useful.

Presumably this is from the CPU trace port, OMAP3 with NO_HZ.

Do I read this right:  18 usec tick processing overhead after
receiving an IRQ, before even getting to the generic OMAP GPIO
irq logic (which then has to dispatch to the real IRQ handler)?
Over 5 usec just for updating jiffies64 ...


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
