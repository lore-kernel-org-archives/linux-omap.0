From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [RFC 1/3] OMAP: clocks: Use clk names instead of clk pointers
Date: Thu, 20 Jan 2011 11:58:38 +0530
Message-ID: <3142d734de48a49dcf7b2e8af0b51b36@mail.gmail.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com>
 <1295446466-23655-2-git-send-email-rnayak@ti.com> <20110119151924.GA3552@legolas.emea.dhcp.ti.com>
 <504b9356bcc91cc2316b1623095e4f64@mail.gmail.com> <20110120062655.GD2389@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58497 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752430Ab1ATG2l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:28:41 -0500
Received: by fxm17 with SMTP id 17so263841fxm.34
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:28:39 -0800 (PST)
In-Reply-To: <20110120062655.GD2389@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Thursday, January 20, 2011 11:57 AM
> To: Rajendra Nayak
> Cc: balbi@ti.com; linux-omap@vger.kernel.org; paul@pwsan.com;
khilman@deeprootsystems.com
> Subject: Re: [RFC 1/3] OMAP: clocks: Use clk names instead of clk
pointers
>
> Hi,
>
> On Thu, Jan 20, 2011 at 11:03:38AM +0530, Rajendra Nayak wrote:
> > Did you look at this part of the patch?
>
> missed that one. Should you then split: one patch dropping const and
> another doing the plat/clock.c changes ?

I could. Will do that in the next spin to avoid confusion.

>
> --
> balbi
