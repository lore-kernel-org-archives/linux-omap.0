From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and AUTO_OFF being enabled simultaneously
Date: Tue, 16 Jun 2009 07:28:18 -0700
Message-ID: <877hzc5k3h.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03059BC5AB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:43433 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbZFPO2S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 10:28:18 -0400
Received: by pzk17 with SMTP id 17so2728167pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 07:28:21 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03059BC5AB@dbde02.ent.ti.com> (Rajendra Nayak's message of "Tue\, 16 Jun 2009 18\:46\:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
>>
>>ext Rajendra Nayak <rnayak@ti.com> writes:
>>
>>> There is a design requirement in OMAP3 that Auto_RET and AUTO_OFF
>>> should not be set together. The PRCM FSM  has been coded assuming
>>> that SW will set either auto_ret or auto_off bit depending on
>>> whether the core has been programmed to go into open switched
>>> logic retention state or OFF state. They are mutually exclusive.
>>
>>So we don't have to do this if closed switch retention is used? (This
>>is what is currently used in linux-omap:pm)
>
> Currently in the pm branch AUTO_RET is enabled at init and kept
> enabled. While attempting a OFF state AUTO_OFF is enabled also
> leaving AUTO_RET and AUTO_OFF both enabled.

A little more clarification needed, in particular whether or how
this affects closed-switch retention.

The description above states that this problem affects OSWR and OFF.
linux-omap PM only uses CSWR, so based on the description of the PRCM
=46SM above, for CSWR, we should never be setting AUTO_RET when using
CSWR.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
