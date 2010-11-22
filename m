From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 2/5] omap4: l2x0: Construct the AUXCTRL value using defines
Date: Mon, 22 Nov 2010 20:21:12 +0000
Message-ID: <yw1xoc9h2jpj.fsf@unicorn.mansr.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
	<8762vpp19m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:51889 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab0KVUVP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 15:21:15 -0500
In-Reply-To: <8762vpp19m.fsf@deeprootsystems.com> (Kevin Hilman's message of "Mon, 22 Nov 2010 12:11:01 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, nm@ti.com, mans@mansr.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> This patch removes the hardcoded value of auxctrl value and
>> construct it using bitfields
>>
>> Bit 25 is reserved and is always set to 1. Same value
>> of this bit is retained in this patch
>
> Is this OMAP specific, or is this ARM generic?

The bit fields are generic PL310.  It has to be set from OMAP code due
to the ROM call.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
