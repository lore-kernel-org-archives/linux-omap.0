From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Wed, 16 Feb 2011 09:30:17 +0530
Message-ID: <AANLkTikXO0DS3oM8q+pMDhQ9u=b7RrNBh5W3pa1YyLZX@mail.gmail.com>
References: <1297406718-24147-1-git-send-email-j-keerthy@ti.com>
	<877hd2xivn.fsf@ti.com>
	<AANLkTikdDsq0mku6Jakq-cxA3jYYHQ7CL0sjwJ6wzXNh@mail.gmail.com>
	<20110215235222.GL15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38161 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755797Ab1BPEAT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 23:00:19 -0500
In-Reply-To: <20110215235222.GL15795@trinity.fluff.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-i2c@fluff.org>
Cc: Kevin Hilman <khilman@ti.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Richard woodruff <r-woodruff2@ti.com>

On Wed, Feb 16, 2011 at 5:22 AM, Ben Dooks <ben-i2c@fluff.org> wrote:
> On Tue, Feb 15, 2011 at 10:13:58AM +0530, J, KEERTHY wrote:
>> On Tue, Feb 15, 2011 at 5:35 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> > Keerthy <j-keerthy@ti.com> writes:
>> >
>> >> From: Richard woodruff <r-woodruff2@ti.com>
>> >>
>> >> ProDB00017052 - ARDY interrupt reasserted after being cleared.
>> >
>> >> This errata caused intermittent i2c instabilty(1 error per 3 hour=
s) on several
>> >> customer platforms. After applying the workaround the intermitten=
t errors were
>> >> not seen. This is not captured in the usual errata documents.
>> >
>> > This (presumably internal) ProDB number above is meaningless in th=
e
>> > public changelog. =A0In lieu of a public erratum number, just summ=
arize
>> > the erratum/instability seen, references to other relevant public
>> > errata (if any) would be useful too. =A0 IOW, "instability" isn't =
quite
>> > accurate enough. =A0A more detailed description of the problem/ins=
tability
>> > is needed.
>> >
>>
>> Kevin,
>>
>> Yes the ProDB number is internal. I will remove it from the change l=
og.
>> I will add a more detailed description of the problem.
>
> Leave it in a comment at the most, it might be useful, otherwise plea=
se
> respond to Kevin's review and then it'll be ready to merge.
>

Ben,

I will add a more detailed description.

--=20
Regards and Thanks,
Keerthy

>> --
>> Regards and Thanks,
>> Keerthy
>>
>>
>> > Thanks,
>> >
>> > Kevin
>> >
>> >>
>> >> The workaround is to have a double clear of ARDY status in
>> >> irq handler.
>> >>
>> >> Signed-off-by: Richard woodruff <r-woodruff2@ti.com>
>> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> >> ---
>> >> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A03 ++-
>> >> =A01 files changed, 2 insertions(+), 1 deletions(-)
>> >>
>> >> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i=
2c-omap.c
>> >> index 445de08..9bcefae 100644
>> >> --- a/drivers/i2c/busses/i2c-omap.c
>> >> +++ b/drivers/i2c/busses/i2c-omap.c
>> >> @@ -851,7 +851,8 @@ complete:
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_I2C_STAT_AL)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev=
, stat &
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP=
_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2=
C_STAT_XRDY | OMAP_I2C_STAT_XDR));
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2=
C_STAT_XRDY | OMAP_I2C_STAT_XDR |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2=
C_STAT_ARDY));
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_complete_cmd=
(dev, err);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disa=
ppear.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
