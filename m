From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] Group and resource assignments for TWL4030
Date: Fri, 13 Mar 2009 15:11:06 -0800
Message-ID: <200903131611.06785.david-b@pacbell.net>
References: <20090306001625.GF6784@atomide.com> <1236958391-17197-1-git-send-email-peter.de-schrijver@nokia.com> <1236958391-17197-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:35980 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758018AbZCMXLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2009 19:11:10 -0400
In-Reply-To: <1236958391-17197-2-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Friday 13 March 2009, Peter 'p2' De Schrijver wrote:
> =A0struct twl4030_power_data {
> =A0=A0=A0=A0=A0=A0=A0=A0struct twl4030_script **scripts;
> -=A0=A0=A0=A0=A0=A0=A0unsigned size;
> +=A0=A0=A0=A0=A0=A0=A0unsigned scripts_size;

And that little bit breaks builds ... since the various
bits of code that initialize a twl4030_power_data have
not been changed.

I'll send an updated version of this patch soonish.


> +=A0=A0=A0=A0=A0=A0=A0struct twl4030_resconfig *resource_config;
> =A0};


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
