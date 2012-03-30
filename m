From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 13:51:42 +0530
Message-ID: <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>
References: <1333094862.1932.15.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:50662 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759610Ab2C3IWE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 04:22:04 -0400
Received: by qadb15 with SMTP id b15so331609qad.2
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 01:22:02 -0700 (PDT)
In-Reply-To: <1333094862.1932.15.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Mar 30, 2012 at 1:37 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> I just found out about OMAP4 errata i740:
>
> DESCRIPTION
> A bug has been identified in the interconnect agent handling the connect-disconnect protocol between an
> initiator and interconnect. When the disconnect protocol violation occurs, there is a dead lock and a
> system lockup is observed.
>
> The issue can occur in a corner case when the impacted module has started a transition to standby, for
> the L3 initiator on which it is attached, exactly at the time the initiator gets an event for exiting idle state.
> Such a situation can occur when the impacted initiator is generating short MStandby pulses (pulse
> durations less than one L4 clock cycle).
>
> DSS and ISS are the only initiators that are impacted.
>
> WORKAROUND
> L3_CLK1 must be kept in NO-IDLE when the DSS clock domain is ON. It can be switched back to
> HW_AUTO when the DSS clock domain is IDLE.
>
> L3_CLK2 must be kept in NO-IDLE when the ISS clock domain is ON. It can be switched back to
> HW_AUTO when the ISS clock domain is IDLE.
>
>
> All OMAP4 versions seem to be affected. I couldn't find a mention about
> this in the mainline kernel. Any ideas how and where this should be
> fixed?
>
It's not patched for mainline. Generally clock-domain code
is abstracted from drivers but considering the errata and affected
modules, I guees it should be handled by DSS driver
since that is where the state of DSS or ISS will be known. Note
ISS will be automatically taken care since it will always use disaplay.

In internal tree's this was handled as part of DSS early suspend/resume

Regards
Santosh
