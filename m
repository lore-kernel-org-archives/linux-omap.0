From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 3/8 v2] ARM OMAP2+ GPMC: add bus children
Date: Wed, 25 Feb 2015 17:23:01 +0100
Message-ID: <54EDF6E5.9070405@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDB9F0.9030701@ti.com> <54EDE4F1.10000@cit-ec.uni-bielefeld.de> <54EDF5DE.9010607@ti.com>
Reply-To: rabel@cit-ec.uni-bielefeld.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49146 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbBYQXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 11:23:02 -0500
In-Reply-To: <54EDF5DE.9010607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk

Hi Roger,

On 25 Feb 2015 17:18, Roger Quadros wrote:
> OK. Would be interesting to see how unconditional call to of_platform_decide_create() behaves
> for your case.
I'm not able to test today, so results will be in tomorrow. If that 
doesn't work, I'll just resubmit my first patch with the conditional.

I'll be posting a v3 of this entire patch series tomorrow after testing. 
I think I should leave your ACKs out for you to re-ACK?

Regards,

Robert
