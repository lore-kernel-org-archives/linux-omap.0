From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and AUTO_OFF being enabled simultaneously
Date: Tue, 16 Jun 2009 10:28:25 -0700
Message-ID: <87d4942ime.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03059BC5AB@dbde02.ent.ti.com>
	<877hzc5k3h.fsf@deeprootsystems.com>
	<92CDD168D1E81F4F9D3839DC45903FC6536982E1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f201.google.com ([209.85.221.201]:65261 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZFPR2g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 13:28:36 -0400
Received: by qyk39 with SMTP id 39so380962qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 10:28:38 -0700 (PDT)
In-Reply-To: <92CDD168D1E81F4F9D3839DC45903FC6536982E1@dlee03.ent.ti.com> (David Derrick's message of "Tue\, 16 Jun 2009 11\:12\:31 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Derrick, David" <dderrick@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>

Hi David,

Thanks for the extra clarifications.  Is this Table you sent in the
TRM somewhere?  I don't find it in my ES3.1 NDA TRM ver. P.

=46or the various C-states in CPUidle, we do indeed have various
combinations of MPU and CORE state, from cpuidle34xx.c:

/* omap3_init_power_states - Initialises the OMAP3 specific C states.
 *
 * Below is the desciption of each C state.
 * 	C1 . MPU WFI + Core active
 *	C2 . MPU WFI + Core inactive
 *	C3 . MPU CSWR + Core inactive
 *	C4 . MPU OFF + Core inactive
 *	C5 . MPU CSWR + Core CSWR
 *	C6 . MPU OFF + Core CSWR
 *	C7 . MPU OFF + Core OFF
 */

Maybe the right solution is to have the PRM_VOLTCTRL value associated
with the C-state so we minimize the amount of conditional logic we
have to do in idle loop itself.  Otherwise tracking all these
combinations in the idle loop could get ugly.  We also don't currently
do anything with AUTO_SLEEP, and it looks like we should.

But, getting back to the original patch, based on the table you sent,
the description in the original patch makes even less sense to me.  It
says basically that AUTO_RET and AUTO_OFF are mutually exclusive.  The
table suggests otherwise, and shows that you'll never hit 0V unless
both are set.

So I still think the original patch description needs an update.

Kevin

"Derrick, David" <dderrick@ti.com> writes:

> Kevin,
>
> =20
>
> Not sure this change has been done yet. But basically when you have m=
is-matched
> power states between the MPU and CORE, you may run into a situation w=
here the
> voltage does not scale. As long as both MPU and CORE go into the same=
 power
> state then there is not a problem. See the following table to better
> understand:
>
> =20
>
>                                                                      =
                                                   =20
> Table 1.          AUTO Voltage Scaling
>
> +--------------------------------------------------------------------=
--------------------------------+
> |MPU=A0 Power     |CORE Power State |AUTO_OFF    |AUTO_RETENTION    |=
AUTO_SLEEP    |VDD1    |VDD2      |
> |State          |                 |            |                  |  =
            |        |          |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |      OFF      |       OFF       |     0      |        1         |  =
    1       |  1.0V  |   0.9V   |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |      OFF      |       OFF       |     0      |        1         |  =
    0       |  0.9V  |   0.9V   |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |      OFF      |       OFF       |     1      |        1         |  =
    1       |0V/0.6V*|0V/0.6mV* |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |      OFF      |  OSWR or CSWR   |     0      |        1         |  =
    1       |  1.0V  |   0.9V   |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |      OFF      |  OSWR or CSWR   |     0      |        1         |  =
    0       |  0.9V  |   0.9V   |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |      OFF      |  OSWR or CSWR   |     1      |        1         |  =
    1       |  1.2V  |  1.15V   |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |     CSWR      |  ON (INACTIVE)  |     0      |        1         |  =
    0       |  0.9V  |  1.15V   |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |     CSWR      |  ON (INACTIVE)  |     0      |        1         |  =
    1       |  0.9V  |   1.0V   |
> |---------------+-----------------+------------+------------------+--=
------------+--------+----------|
> |     CSWR      |  ON (INACTIVE)  |     0      |        0         |  =
    1       |  1.0V  |   1.0V   |
> +--------------------------------------------------------------------=
--------------------------------+
>
> * Using SYS_OFFMODE / Using I2C4
>
> =20
>
> =20
>
> You need to dynamically enable and disable the auto voltage scaling (=
AUTO_OFF,
> AUTO_RET and AUTO_SLEEP) based on which sleep configuration you are g=
oing into
> for MPU and CORE.
>
> =20
>
> Regards,
>
> David
>
> =20
>
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, June 16, 2009 9:28 AM
> To: Nayak, Rajendra
> Cc: H=F6gander Jouni; linux-omap@vger.kernel.org; Derrick, David; Woo=
druff,
> Richard
> Subject: Re: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and AUTO_OFF b=
eing
> enabled simultaneously
>
> =20
>
> "Nayak, Rajendra" <rnayak@ti.com> writes:
>
> =20
>
>>From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
>
>>>=20
>
>>>ext Rajendra Nayak <rnayak@ti.com> writes:
>
>>>=20
>
>>>> There is a design requirement in OMAP3 that Auto_RET and AUTO_OFF
>
>>>> should not be set together. The PRCM FSM=A0 has been coded assumin=
g
>
>>>> that SW will set either auto_ret or auto_off bit depending on
>
>>>> whether the core has been programmed to go into open switched
>
>>>> logic retention state or OFF state. They are mutually exclusive.
>
>>>=20
>
>>>So we don't have to do this if closed switch retention is used? (Thi=
s
>
>>>is what is currently used in linux-omap:pm)
>
>>=20
>
>> Currently in the pm branch AUTO_RET is enabled at init and kept
>
>> enabled. While attempting a OFF state AUTO_OFF is enabled also
>
>> leaving AUTO_RET and AUTO_OFF both enabled.
>
> =20
>
> A little more clarification needed, in particular whether or how
>
> this affects closed-switch retention.
>
> =20
>
> The description above states that this problem affects OSWR and OFF.
>
> linux-omap PM only uses CSWR, so based on the description of the PRCM
>
> FSM above, for CSWR, we should never be setting AUTO_RET when using
>
> CSWR.
>
> =20
>
> Kevin
>
> =20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
