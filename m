From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/2] OMAP: Make dpll4_m4_ck programmable with clk_set_rate()
Date: Sat, 06 Dec 2008 01:40:02 +0000
Message-ID: <yw1xtz9iytcd.fsf@thrashbarg.mansr.com>
References: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com>
	<1224545064-25551-1-git-send-email-mans@mansr.com>
	<alpine.DEB.2.00.0812051650380.21247@utopia.booyaka.com>
	<20081206001153.GO9714@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:54026 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156AbYLFBt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 20:49:59 -0500
In-Reply-To: <20081206001153.GO9714@atomide.com> (Tony Lindgren's message of "Fri, 5 Dec 2008 16:11:54 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mans Rullgard <mans@mansr.com>, linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com

Tony Lindgren <tony@atomide.com> writes:

> * Paul Walmsley <paul@pwsan.com> [081205 15:52]:
>> On Tue, 21 Oct 2008, Mans Rullgard wrote:
>>=20
>> > Filling the set_rate and round_rate fields of dpll4_m4_ck makes
>> > this clock programmable through clk_set_rate().  This is needed
>> > to give omapfb control over the dss1_alwon_fck rate.
>> >=20
>> > Signed-off-by: Mans Rullgard <mans@mansr.com>
>>=20
>> Acked-by: Paul Walmsley <paul@pwsan.com>
>>=20
>> M=E5ns, sorry this took so long, these two patches slipped through t=
he=20
>> cracks here.
>
> Pushing both to l-o tree today. Paul, I take it you will queue these
> up for mainline via your clock series?
>
> M=E5ns, I heard you have some display patches? How about queuing up
> those on the fbdev list?

It looks like Tomi's driver is shaping up nicely, so it's probably not
worthwhile spending any significant time on the current driver.  If
anyone is interested, everything I have is in my git tree.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
