From: "arun c" <arun.edarath@gmail.com>
Subject: Re: [PATCH] omapfb: setting GOLCD bit for shadow registers to make effect
Date: Tue, 9 Sep 2008 10:07:41 +0530
Message-ID: <c656a4d20809082137m60ca05c0q33987a91b075e56c@mail.gmail.com>
References: <c656a4d20809080219q545ccff3v13221d2287f6de30@mail.gmail.com>
	 <yw1xtzcq76dr.fsf@thrashbarg.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:37673 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYIIEho convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 00:37:44 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1086685tic.23
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2008 21:37:42 -0700 (PDT)
In-Reply-To: <yw1xtzcq76dr.fsf@thrashbarg.mansr.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 9, 2008 at 1:32 AM, M=E5ns Rullg=E5rd <mans@mansr.com> wrot=
e:
> "arun c" <arunedarath@mistralsolutions.com> writes:
>
>> A shadow register change has no direct effect on the display
>> configuration until the GOLCD (DISPC_CONTROL[5]) is set.
>>
>> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
>> ---
>>  drivers/video/omap/dispc.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
>> index 82ba030..2e7af85 100644
>> --- a/drivers/video/omap/dispc.c
>> +++ b/drivers/video/omap/dispc.c
>> @@ -436,6 +436,11 @@ static inline int _setup_plane(int plane, int c=
hannel_out,
>>
>>       dispc_write_reg(ri_reg[plane], (screen_width - width) * bpp / =
8 + 1);
>>
>> +     /* Wait untill GOLCD bit is cleared and set it */
>
> Nit: "until" (one l)
>
>> +     while (dispc_read_reg(DISPC_CONTROL) & (1 << 5))
>> +             continue;
>> +     MOD_REG_FLD(DISPC_CONTROL, 1 << 5, 1 << 5);
>> +
>>       return height * screen_width * bpp / 8;
>>  }
>
> This looks good.  However, the same thing is needed in
> omap_dispc_enable_plane() as well.  Placing the loop+set in a functio=
n
> (go_lcd()?) would make sense.
>
Thanks.
Yes that will be nice, I still see  modification of shadow registers
in some more places with out issuing a GOLCD. I agree the best
method is to make it a function

> --
> M=E5ns Rullg=E5rd
> mans@mansr.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
