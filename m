From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 06/12] staging: tidspbridge: convert core to list_head
Date: Mon, 8 Nov 2010 13:16:22 -0600
Message-ID: <AANLkTikxaqWoBynTqMhrZ0mPti4JHiXvkz9=su-OKeRF@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
	<AANLkTinEa8y1AfeNDKa6gDcDoL-s6BKU_RLyr4BRUDDJ@mail.gmail.com>
	<1289064703.9931.49.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38213 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751649Ab0KHTQX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 14:16:23 -0500
Received: by mail-wy0-f181.google.com with SMTP id 40so7098888wyb.40
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 11:16:22 -0800 (PST)
In-Reply-To: <1289064703.9931.49.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Ionut,

On Sat, Nov 6, 2010 at 11:31 AM, Ionut Nicu <ionut.nicu@mindbit.ro> wro=
te:
> Hi Rene,
>
> On Fri, 2010-11-05 at 16:12 -0600, Sapiens, Rene wrote:
>> Hi Ionut,
>>
>> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wr=
ote:
>> > Convert the core module of the tidspbridge driver
>> > to use struct list_head instead of struct lst_list.
>> >
>> > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
>>
>> <snip>
>>
>> > diff --git a/drivers/staging/tidspbridge/core/io_sm.c b/drivers/st=
aging/tidspbridge/core/io_sm.c
>> > index 194bada..9851f32 100644
>> > --- a/drivers/staging/tidspbridge/core/io_sm.c
>> > +++ b/drivers/staging/tidspbridge/core/io_sm.c
>>
>> <snip>
>>
>> > @@ -1106,47 +1103,38 @@ static void input_msg(struct io_mgr *pio_m=
gr, struct msg_mgr *hmsg_mgr)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 * queued.
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(*hmsg_mgr->on_exit) ((void *)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg_queue_obj->arg,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg.msg.dw_arg1);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_queue_obj->arg,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg.msg.dw_arg1);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
 Not an exit acknowledgement, queue
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
 the message.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (=
!list_empty(&msg_queue_obj->msg_free_list)) {
>>
>> You are going beyond the 80 chars.
>>
>
> I thought about it too when using scripts/checkpatch.pl on this patch=
=2E
> The thing is that it's 81 chars and breaking it into two lines makes =
it
> look uglier. Also, this gets fixed in patch 10/12 (core code cleanup)=
=2E

I think that it would be better to see every patch as a single element =
which
would accomplish with all the standards, what if the patch 10/12 doesn'=
t get
merged?...

Probably we can keep this line uglier in this patch and make it prettie=
r in the
10/12 one or even better, make it prettier in this patch.

>
> Regards,
> Ionut.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
