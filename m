From: "iqbal" <iqbal@ti.com>
Subject: Re: OMAPFB problem on 3430SDP
Date: Wed, 30 Jul 2008 12:21:48 +0530 (IST)
Message-ID: <44837.192.168.10.88.1217400708.squirrel@dbdmail.itg.ti.com>
References: <1217399743.25700.7.camel@tubuntu>
Reply-To: iqbal@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:58564 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbYG3Gv6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jul 2008 02:51:58 -0400
In-Reply-To: <1217399743.25700.7.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Tomi,

> When running linux-omap kernel on 3430SDP board (version VG5.0.0), the
> picture on the LCD is very green. It seems to show only green color
> component, or something like that. TI's own kernel works ok.
>
> I've been going through all the DSS registers with Trace32, comparing
> them between working and non-working kernels, but I haven't been able to
> find differences.
>
> Does linux-omap kernel work ok on earlier SDP versions? This one has
> 750-2081-102(B) as a display board, (I think the earlier ones have 101).
> Any ideas what could be missing?
>
This problem is seen on the older SDP versions too, all have 750-2081-102(B)
display. Something to do with linux-omap code, I am sure TI's 2.6.24 code
has a fix.

Regards
Iqbal
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


