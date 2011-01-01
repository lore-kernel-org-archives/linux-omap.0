From: Felipe Balbi <balbi@ti.com>
Subject: Re: [QUESTION] what's the problem with CBUS ?
Date: Sat, 1 Jan 2011 02:01:47 +0200
Message-ID: <20110101000147.GA2321@legolas.emea.dhcp.ti.com>
References: <20101227171309.GA2235@legolas.emea.dhcp.ti.com>
 <20101227171815.GB2235@legolas.emea.dhcp.ti.com>
 <20101230205331.GF7771@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43377 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754334Ab1AAABw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Dec 2010 19:01:52 -0500
Received: by ewy27 with SMTP id 27so6418462ewy.0
        for <linux-omap@vger.kernel.org>; Fri, 31 Dec 2010 16:01:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101230205331.GF7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Dec 30, 2010 at 12:53:31PM -0800, Tony Lindgren wrote:
>Hi,
>
>Sorry for the delay in responding, mostly in read-only mode this
>week :)
>
>* Felipe Balbi <balbi@ti.com> [101227 09:17]:
>> >
>> >What was the problem you saw with N810 which caused the need for
>> >commit fc8c2f1dba400e9a0d1d82756e0e2f52dfe2f4b6, quoted below ?
>
>Heh found it after some debugging, we need to call init_completion :)

Cool, good one. I'll start working on moving to genirq, already have a
few patches on my cbus branch.

-- 
balbi
