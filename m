From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3 PM Add sysfs entry for EFuse values
Date: Tue, 13 Oct 2009 14:38:32 -0500
Message-ID: <782515bb0910131238r31a00aa7ub0b576d798d6e761@mail.gmail.com>
References: <1255358890-9434-1-git-send-email-peter.de-schrijver@nokia.com>
	 <87ws2zkubi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:35763 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934097AbZJMTio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:38:44 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so10618629fxm.17
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 12:38:33 -0700 (PDT)
In-Reply-To: <87ws2zkubi.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

On Tue, Oct 13, 2009 at 1:44 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
>
>> This patch exports the smartreflex efuse values for all 5 OPPs via
>> sysfs. This can be useful to track down silicon specific problems.
>>
>> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com=
>
>
> These should be exported via debugfs instead of sysfs.
>
> Also, the SR rewrite is underway and will be merged shortly, so I
> recommend waiting until that is in place before we add this. =A0Unles=
s
> Nishanth wants to add it sooner.
>
I can add it as part of my v3 patchset.
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
