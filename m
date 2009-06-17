From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and AUTO_OFF being
 enabled simultaneously
Date: Wed, 17 Jun 2009 11:57:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305A53FD3@dbde02.ent.ti.com>
References: <877hzc5k3h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55583 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbZFQG1w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 02:27:52 -0400
In-Reply-To: <877hzc5k3h.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

=20

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
>Sent: Tuesday, June 16, 2009 7:58 PM
>To: Nayak, Rajendra
>Cc: H=F6gander Jouni; linux-omap@vger.kernel.org; Derrick,=20
>David; Woodruff, Richard
>Subject: Re: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and=20
>AUTO_OFF being enabled simultaneously
>
>"Nayak, Rajendra" <rnayak@ti.com> writes:
>
>>From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
>>>
>>>ext Rajendra Nayak <rnayak@ti.com> writes:
>>>
>>>> There is a design requirement in OMAP3 that Auto_RET and AUTO_OFF
>>>> should not be set together. The PRCM FSM  has been coded assuming
>>>> that SW will set either auto_ret or auto_off bit depending on
>>>> whether the core has been programmed to go into open switched
>>>> logic retention state or OFF state. They are mutually exclusive.
>>>
>>>So we don't have to do this if closed switch retention is used? (Thi=
s
>>>is what is currently used in linux-omap:pm)
>>
>> Currently in the pm branch AUTO_RET is enabled at init and kept
>> enabled. While attempting a OFF state AUTO_OFF is enabled also
>> leaving AUTO_RET and AUTO_OFF both enabled.
>
>A little more clarification needed, in particular whether or how
>this affects closed-switch retention.

Sorry, that was a wrong description. AUTO_RET could be used to scale th=
e voltage
down even in case of CSWR and not just OSWR.

The idea of this patch was to enable auto voltage scaling only for the =
last 3 C states.

 *	C5 . MPU CSWR + Core CSWR - AUTO RET enabled
 *	C6 . MPU OFF + Core CSWR - AUTO RET enabled
 *	C7 . MPU OFF + Core OFF - AUTO OFF enabled.

=46or the rest of the Lower C states the decision of not enabling AUTO =
RET/OFF was to keep
the latency for such states down.

Especially with SR enabled having AUTO RET/OFF enabled for say  a MPU R=
ET/CORE inactive
state would mean a 2 level voltage change. First to scale from SR autoc=
ompensated level to the
actual OPP voltage level (That's done when you disable SR) and then fro=
m the there to the
AUTO RET level.
So say you hit MPU RET/CORE inactive state at OPP3 (1.2v) which has a S=
R autocompensated voltage
to 1.08v, then you would scale from 1.08->1.2->0.975.
That might be too much of additional latency to incure in case of a MPU=
 RET/CORE inactive
state.=20

>
>The description above states that this problem affects OSWR and OFF.
>linux-omap PM only uses CSWR, so based on the description of the PRCM
>FSM above, for CSWR, we should never be setting AUTO_RET when using
>CSWR.
>
>Kevin
>
>--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
