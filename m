From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] ARM: ensure all sched_clock() implementations are notrace marked
Date: Thu, 16 Dec 2010 20:42:23 +0530
Message-ID: <AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com>
References: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:56852 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0LPPM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 10:12:26 -0500
In-Reply-To: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Lennert Buytenhek <kernel@wantstofly.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Thu, Dec 16, 2010 at 1:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> ftrace requires sched_clock() to be notrace. =A0Ensure that all
> implementations are so marked.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

It does seem better to have all of them explicity annotated anyway, eve=
n
if it not required in most of the cases because they include
<linux/sched.h> and the annotation in the declaration takes effect.

Note that in order for this to be fully effective, all functions called
from sched_clock() need to be notrace too.  OMAP and u300 miss this.
The following patches fix them up; perhaps you can fold them into this
one.  If not, I will rebase them later after this series is merged:

http://www.spinics.net/lists/arm-kernel/msg104616.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38911.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
