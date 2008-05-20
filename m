From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] 34XX: PM: Support for retention on suspend and idle
Date: Tue, 20 May 2008 15:13:58 -0700
Message-ID: <20080520221357.GQ23002@atomide.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:53250 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760177AbYETWN4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 18:13:56 -0400
Content-Disposition: inline
In-Reply-To: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

* H=F6gander Jouni <jouni.hogander@nokia.com> [080516 03:54]:
> This patch set adds suspend and pm idle support for omap3. There are
> still lots of missing stuff so omap doesn't enter full retention
> without workaround patches. Workaround patches are sent in separate
> set.
>=20
> You can try these by applying this set and workaround set. Then boot
> the device and do "echo mem > /sys/power/state". Dynamic retention ca=
n
> be tried by "echo 1 > /sys/power/sleep_while_idle". There is one
> pending patch by Felipe Balbi (ARCH: OMAP: MUSB: Do not block sleep)
> addition to this and workaround set which is needed dynamic idle to
> work. Enabling dynamic idle has nasty side effect that serial console
> stops to work. This happens only if you enable it by "echo 1 >
> /sys/power/sleep_while_idle"
>=20
> I have tested these patches on TI 3430 SDP ES2.0 board.

Pushing this series today.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
