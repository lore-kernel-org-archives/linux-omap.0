From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 4/8] ARM: etm: Allow range selection
Date: Tue, 15 Feb 2011 15:04:31 -0800
Message-ID: <AANLkTim776VyU_LioTL2-pOjskVDeU4BpFuw6CxGUXRT@mail.gmail.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
	<1297750276-12475-4-git-send-email-arve@android.com>
	<20110215135054.GD18248@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50472 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab1BOXEd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 18:04:33 -0500
In-Reply-To: <20110215135054.GD18248@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.we>

On Tue, Feb 15, 2011 at 5:50 AM, Alexander Shishkin <virtuoso@slind.org=
> wrote:
> On Mon, Feb 14, 2011 at 10:11:12PM -0800, Arve Hj=F8nnev=E5g wrote:
>> Trace kernel text segment by default as before, allow tracing of oth=
er
>> ranges by writing a range to /sys/devices/etm/trace_range, or to tra=
ce
>> everything by writing 0 0.
>
> Since you're adding this, I think it might make sense to add a 3rd op=
tional
> ctx id field, so that userspace tracing is also possible, especially =
when
> on-chip ETB sizes increase to something more sensible than what they =
are
> these days.
>

That might be useful, but I think it can be added later. My main
motivation for adding this is so we can turn off the filtering. We
want to use tracing in combination with a hardware watchdog to debug
hard lockups and we don't want any filtering in this case.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
