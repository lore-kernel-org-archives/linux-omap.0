From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Tue, 8 Mar 2011 11:23:35 +0530
Message-ID: <bf0965b01771bcc24af38e4d0d687a4b@mail.gmail.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org><AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com><7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com>
 <87d3m2397s.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49475 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214Ab1CHFxi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 00:53:38 -0500
Received: by qyk36 with SMTP id 36so3275419qyk.4
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 21:53:37 -0800 (PST)
In-Reply-To: <87d3m2397s.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Tuesday, March 08, 2011 3:05 AM
> To: Santosh Shilimkar
> Cc: Dave Martin; linux-arm-kernel@lists.infradead.org;
> patches@linaro.org; Tony Lindgren; Jean Pihet-XID; linux-
> omap@vger.kernel.org; Nicolas Pitre; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2
> compatibility fixes
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > Dave,
> >> -----Original Message-----
> >> From: Dave Martin [mailto:dave.martin@linaro.org]
> >> Sent: Friday, March 04, 2011 11:05 PM
> >> To: linux-arm-kernel@lists.infradead.org
> >> Cc: patches@linaro.org; Tony Lindgren; Santosh Shilimkar; Jean
> >> Pihet; Kevin Hilman; linux-omap@vger.kernel.org; Nicolas Pitre;
> >> linaro-dev@lists.linaro.org
> >> Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2
> >> compatibility fixes
> >>
> >> On Fri, Mar 4, 2011 at 3:33 PM, Dave Martin
> <dave.martin@linaro.org>
> >> wrote:
> >> > This set of patches, along with some other patches under
> >> > discussion on alkml, should enable omap3 and omap4 kernels to
> be
> >> > built with CONFIG_THUMB2_KERNEL.
> >> >
> >> > This patch set builds on recent cleanup done by the omap
> >> > maintainers.
> >> >
> >> > At least some of this code definitely works, most features have
> >> > been tested successfully. =A0Further testing, especially of
> Thumb-2
> >> > behaviour, is still welcome.
> >> >
> >> > In particular, I still have no Ack/Tested-by on the following
> >> > patches, so it would be great if anyone who has an opportunity
> >> > to do a final review / re-test can do so.
> >> >
> >> > =A0* ARM: omap3: Convert END() to ENDPROC() for correct linkage
> with
> >> CONFIG_THUMB2_KERNEL
> >> > =A0* ARM: omap3: Thumb-2 compatibility for sram34xx.S
> >> > =A0* ARM: omap3: Thumb-2 compatibility for sleep34xx.S
> >>
> >> Following up on this, it looks like I have some locally-recorded
> >> acks
> >> which didn't make it into my posting ...
> >>
> >> The one patch I currently have no feedback on is this one:
> >>
> >>   * ARM: omap4: Provide do_wfi() for Thumb-2
> >>
> > You can drop this one since do_wfi()  won't be needed
> > anymore after my recent series.
> >
> > http://www.spinics.net/lists/linux-omap/msg46495.html
>
> Santosh,
>
> I'm planning to queue/merge Dave's series as-is for 2.6.39, since it
> has
> already received significan review & testing.
>
> When you update your OMAP4 series, feel free to drop it as needed.
>
=46ine with me.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
