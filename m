From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] ARM: OMAP3+: PM debug: fix the use of debugfs_create_* API
Date: Wed, 1 Feb 2012 09:34:15 +0100
Message-ID: <CAORVsuWbRDFGGgs2hg3-9cz-Pd16B97QRU-5c4QQ4C6S_uLRog@mail.gmail.com>
References: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
	<87ehufojh1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56418 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab2BAIeQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:34:16 -0500
Received: by vcge1 with SMTP id e1so801242vcg.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:34:16 -0800 (PST)
In-Reply-To: <87ehufojh1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Kevin,

On Tue, Jan 31, 2012 at 6:44 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> The debugfs_create_* API returns a NULL ptr in case of problem.
>> Fix the PM debug code to take this into account.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm-debug.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm=
-debug.c
>> index 4411163..e5bf367 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -264,8 +264,8 @@ static int __init pm_dbg_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 d =3D debugfs_create_dir("pm_debug", NULL);
>> - =A0 =A0 if (IS_ERR(d))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(d);
>> + =A0 =A0 if (!d)
>
> I think this should be IS_ERR_OR_NULL() because this function can als=
o
> return ERR_PTR(-ENODEV). =A0(Yes, only when debugfs is not enabled, b=
ut
> it's still more correct.)
That makes sense, even if the PM debug code is enclosed by #ifdef
CONFIG_DEBUG_FS.
I have a new version of the patch, it also fixes another potential
problem with debugfs.

Thanks,
Jean

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
