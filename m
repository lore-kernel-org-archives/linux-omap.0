From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: 34xx off-mode support fixes
Date: Fri, 04 Jul 2008 08:11:43 +0300
Message-ID: <87zloynshc.fsf@trdhcp146196.ntc.nokia.com>
References: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49197 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbYGDFLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 01:11:49 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m645BL4q010493
	for <linux-omap@vger.kernel.org>; Fri, 4 Jul 2008 00:11:47 -0500
In-Reply-To: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com> (ext
	Tero Kristo's message of "Thu, 3 Jul 2008 18:59:13 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Tero,

"ext Tero Kristo" <tero.kristo@nokia.com> writes:

> Hi,
>
> This patch set contains some experimental fixes for the cpu-idle supp=
ort from
> Rajendra Nayak. With this patch set, all power domains enter OFF mode=
 and
> recover from it, at least while using suspend and/or dynamic idle. If=
 you
> are using these patches, you should disable CPU_IDLE support from ker=
nel
> config as I am not certain it works with this patch set yet. The last=
 patch
> contains some trial fix to cpuidle code, so it might work also if you=
 are
> lucky enough.

Do you have any guesses what is wrong in Rajendras cpuidle
code? Is it that dma save/restore? At least I couldn't figure it out
from your patches.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
