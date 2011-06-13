From: "Vadillo, Miguel" <vadillo@ti.com>
Subject: Re: [PATCH] omap4: fix build error when undefining CONFIG_SMP
Date: Mon, 13 Jun 2011 09:49:27 -0500
Message-ID: <BANLkTimN8Gn9ELZxu5BB0R8gyEerM1AtVg@mail.gmail.com>
References: <BANLkTimf9D55OZ+-sOMPw2_WgG3QO_RooQ@mail.gmail.com>
 <4DF5B011.7080709@ti.com> <20110613143501.GG3352@atomide.com> <4DF62202.4040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36963 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753268Ab1FMOtt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 10:49:49 -0400
Received: by mail-iw0-f173.google.com with SMTP id 42so4822935iwl.4
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 07:49:48 -0700 (PDT)
In-Reply-To: <4DF62202.4040304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Yes, sorry about this mistake, the patch its just for an internal tree
and I wasn't careful enough to check the mainline. Sorry about the
noise.

Santosh,

I think is needed in the internal branch p-android-omap-2.6.39

On Mon, Jun 13, 2011 at 9:43 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 6/13/2011 8:05 PM, Tony Lindgren wrote:
>>
>> * Santosh Shilimkar<santosh.shilimkar@ti.com> =C2=A0[110612 23:32]:
>>>
>>> On 6/13/2011 11:55 AM, Vadillo, Miguel wrote:
>>>>
>>>> Function omap_smc2 is undeclared when disabling SMP
>>
>> Looks like this won't apply to current mainline kernel, care
>> to check if it's still needed?
>>
> Yep. After checking, looks like patch isn't generated
> against mainline. It's not needed against current mainline.
> Sorry for oversight.
>
>
> Miguel,
> Did you post this by mistake ?
> Looking at hunks it apears to be needed against
> internal tree.
>
> Regards
> Santosh
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
