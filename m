From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 03/06] scratchpad populate
Date: Mon, 08 Sep 2008 15:06:21 +0300
Message-ID: <87fxoargea.fsf@trdhcp146196.ntc.nokia.com>
References: <65457.192.168.10.89.1219755861.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32939 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYIHMFi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 08:05:38 -0400
In-Reply-To: <65457.192.168.10.89.1219755861.squirrel@dbdmail.itg.ti.com> (ext
	Rajendra Nayak's message of "Tue, 26 Aug 2008 18:34:21 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> This patch populates the scratchpad contents
> as expected by the bootROM code.

Who should take care of restoring DPLL5 and IVA
DPLL? CM_CLKEN_PLL_IVA2, CM_CLKSEL1_PLL_IVA2, CM_CLKEN2_PLL and
CM_CLKSEL4_PLL seems to be on their reset values after OFF mode.

Also some fields in CM_CLKEN_PLL are in their reset value (i.e. all
the pwrdn bits). Should these be restored separately in prcm_restore_ct=
x?

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
