From: Dima Zavin <dima@android.com>
Subject: Re: [PATCH] mfd: omap: fix the crash during omap ehci or ohci driver initialization
Date: Wed, 15 Jun 2011 16:25:48 -0700
Message-ID: <BANLkTingZ1A=7YxZ4E4aZ40QETs5MHQnfSYOj9x6sUG2657M9w@mail.gmail.com>
References: <1307367739-20110-1-git-send-email-keshava_mgowda@ti.com>
	<20110606135221.GG12242@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:3332 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab1FOX0A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 19:26:00 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p5FNPtbo028917
	for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 16:25:55 -0700
Received: from gxk21 (gxk21.prod.google.com [10.202.11.21])
	by hpaq14.eem.corp.google.com with ESMTP id p5FNOxO1001790
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 16:25:49 -0700
Received: by gxk21 with SMTP id 21so523405gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 16:25:49 -0700 (PDT)
In-Reply-To: <20110606135221.GG12242@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com

Why is this not just a straight revert of
7e6502d577106fb5b202bbaac64c5f1b065e6daa?

On Mon, Jun 6, 2011 at 6:52 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Jun 06, 2011 at 07:12:19PM +0530, Keshava Munegowda wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> Oops are produced during initialization of ehci and ohci
>> drivers. This is because the run time pm apis are used by
>> the driver but the corresponding hwmod structures and
>> initialization is not merged. hence revering =A0back the
>> commit id 7e6502d577106fb5b202bbaac64c5f1b065e6daa
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>
> Reported-by: Luciano Coelho <coelho@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
