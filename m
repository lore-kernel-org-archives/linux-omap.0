From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and AUTO_OFF being enabled simultaneously
Date: Mon, 29 Jun 2009 14:45:47 -0700
Message-ID: <87fxdi7lys.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305A53FD3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:52343 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZF2Vpr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 17:45:47 -0400
Received: by pzk26 with SMTP id 26so454320pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 14:45:50 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305A53FD3@dbde02.ent.ti.com> (Rajendra Nayak's message of "Wed\, 17 Jun 2009 11\:57\:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>>"Nayak, Rajendra" <rnayak@ti.com> writes:
>>
>>>From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
>>>>
>>>>ext Rajendra Nayak <rnayak@ti.com> writes:
>>>>
>>>>> There is a design requirement in OMAP3 that Auto_RET and AUTO_OFF
>>>>> should not be set together. The PRCM FSM  has been coded assuming
>>>>> that SW will set either auto_ret or auto_off bit depending on
>>>>> whether the core has been programmed to go into open switched
>>>>> logic retention state or OFF state. They are mutually exclusive.
>>>>
>>>>So we don't have to do this if closed switch retention is used? (Th=
is
>>>>is what is currently used in linux-omap:pm)
>>>
>>> Currently in the pm branch AUTO_RET is enabled at init and kept
>>> enabled. While attempting a OFF state AUTO_OFF is enabled also
>>> leaving AUTO_RET and AUTO_OFF both enabled.
>>
>>A little more clarification needed, in particular whether or how
>>this affects closed-switch retention.
>
> Sorry, that was a wrong description. AUTO_RET could be used to scale =
the voltage
> down even in case of CSWR and not just OSWR.
>
> The idea of this patch was to enable auto voltage scaling only for th=
e last 3 C states.
>
>  *	C5 . MPU CSWR + Core CSWR - AUTO RET enabled
>  *	C6 . MPU OFF + Core CSWR - AUTO RET enabled
>  *	C7 . MPU OFF + Core OFF - AUTO OFF enabled.
>
> For the rest of the Lower C states the decision of not enabling AUTO
> RET/OFF was to keep the latency for such states down.
>
> Especially with SR enabled having AUTO RET/OFF enabled for say a MPU
> RET/CORE inactive state would mean a 2 level voltage change. First
> to scale from SR autocompensated level to the actual OPP voltage
> level (That's done when you disable SR) and then from the there to
> the AUTO RET level.  So say you hit MPU RET/CORE inactive state at
> OPP3 (1.2v) which has a SR autocompensated voltage to 1.08v, then
> you would scale from 1.08->1.2->0.975.  That might be too much of
> additional latency to incure in case of a MPU RET/CORE inactive
> state.
>

OK, I've updated the patch description on this one and will push to PM
branch (and pm-2.6.29)

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
