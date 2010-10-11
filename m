From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"
Date: Mon, 11 Oct 2010 10:31:26 +0200
Message-ID: <AANLkTi=DDQJZn5gC3BevufVfELvUsz1_dg_ijz=M0HYU@mail.gmail.com>
References: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
	<87y6a8v48p.fsf@deeprootsystems.com>
	<87eic0ti7p.fsf@deeprootsystems.com>
	<AANLkTimLMZtqkk64xUWDuyPpadtZVb2_+YXF+WNSQW=i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60189 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab0JKIb1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 04:31:27 -0400
Received: by qyk10 with SMTP id 10so3942312qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 01:31:27 -0700 (PDT)
In-Reply-To: <AANLkTimLMZtqkk64xUWDuyPpadtZVb2_+YXF+WNSQW=i@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>

On Sat, Oct 9, 2010 at 8:55 AM, Jean Pihet <jean.pihet@newoldbits.com> =
wrote:
> Kevin,
>
> On Sat, Oct 9, 2010 at 12:47 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
=2E..
>>
>> Since only one part of the original patch introduced a bug, I decide=
d to
>> just fix that bug and keep the fixes for the sparse warnings. =A0I j=
ust
>> posted a patch[1] for the fix. =A0 Please test.
>>
>> Thanks,
>
> Thanks for the follow-up on the patch. I will test asap.
Tested OK on OMAP3EVM with RET & OFF mode in idle path.

Tested-by: Jean Pihet <jean.pihet@newoldbits.com>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
