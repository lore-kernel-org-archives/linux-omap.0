From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up latency figures
Date: Tue, 11 Oct 2011 08:50:59 +0200
Message-ID: <CAN5iSWrqSw0_x=iq2jR5qHQ4wnsOVR-B4PG2Jc5jEauHdgENGw@mail.gmail.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-9-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1110062215270.4611@utopia.booyaka.com>
	<CAORVsuX2PUubPzO3mWTaO0Lg6Mdog8wjDY6hm93qheMwoz27CA@mail.gmail.com>
	<alpine.DEB.2.00.1110101636470.5205@utopia.booyaka.com>
	<alpine.DEB.2.00.1110101652290.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:39565 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702Ab1JKGvB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 02:51:01 -0400
Received: by ywa8 with SMTP id 8so6267359ywa.15
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 23:50:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110101652290.5205@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>

Hi Paul,

On Tue, Oct 11, 2011 at 12:52 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 10 Oct 2011, Paul Walmsley wrote:
>
>> OK. =A0sys_offmode only applies to OFF mode. =A0Voltage scaling can =
also occur
>> during RETENTION and INACTIVE ("sleep"). =A0So were these results wi=
th
>> retention and voltage scaling disabled?
>
> This last sentence should have read:
>
> So were these results with retention and sleep voltage scaling disabl=
ed?
In that case, yes. The scaling timings are only applicable to OFF mode.

I think we need to have a bench setup for the latency measurements.
That way I will be easier to repeat the measurements for next
generation chips and variations.

Regards,
Jean

>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
