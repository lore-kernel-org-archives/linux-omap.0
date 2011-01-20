From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 1/3] OMAP: clocks: Use clk names instead of clk pointers
Date: Thu, 20 Jan 2011 08:26:55 +0200
Message-ID: <20110120062655.GD2389@legolas.emea.dhcp.ti.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com>
 <1295446466-23655-2-git-send-email-rnayak@ti.com>
 <20110119151924.GA3552@legolas.emea.dhcp.ti.com>
 <504b9356bcc91cc2316b1623095e4f64@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37230 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343Ab1ATG1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:27:03 -0500
Received: by mail-yi0-f43.google.com with SMTP id 16so68367yie.16
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:27:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <504b9356bcc91cc2316b1623095e4f64@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com

Hi,

On Thu, Jan 20, 2011 at 11:03:38AM +0530, Rajendra Nayak wrote:
> Did you look at this part of the patch?

missed that one. Should you then split: one patch dropping const and
another doing the plat/clock.c changes ?

-- 
balbi
