From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 05/19] ARM: OMAP4: PM: save/restore all CM1/2 settings
 in OFF mode
Date: Thu, 17 May 2012 12:35:51 +0530
Message-ID: <CAMQu2gwFafCPUwGjexUrsV5TAFBwc6ZgwSSx_uPYuDU42rkG8g@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-6-git-send-email-t-kristo@ti.com> <87zk977ne4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:51669 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759153Ab2EQHGN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 03:06:13 -0400
Received: by qcsg15 with SMTP id g15so1312904qcs.13
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 00:06:11 -0700 (PDT)
In-Reply-To: <87zk977ne4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Axel Haslam <axelhaslam@gmail.com>

On Thu, May 17, 2012 at 4:18 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> Restore all CM1/2 module registers as they are lost in OFF mode.
>
> Save and restore?
>
> Also, as in the previous patch. =A0Can this be done using cluster PM
> notifier as well? =A0 =A0(I realize that this series was probably don=
e
> before the PM notifiers were upstream, but now that we have them, we
> should use them.)
>
Device OFF specific and not related to CPU cluster state as such.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
