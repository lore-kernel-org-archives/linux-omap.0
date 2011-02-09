From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM Architecture and GENERIC_CMOS_UPDATE
Date: Wed, 9 Feb 2011 10:27:36 -0800
Message-ID: <20110209182736.GZ20795@atomide.com>
References: <20110201223252.GG3358@atomide.com>
 <C96ECD0A.239F7%marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13483 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab1BIS2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 13:28:01 -0500
Content-Disposition: inline
In-Reply-To: <C96ECD0A.239F7%marathon96@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grant Erickson <marathon96@gmail.com> [110202 08:56]:
> On 2/1/11 2:32 PM, Tony Lindgren wrote:
> > * Grant Erickson <marathon96@gmail.com> [110128 16:34]:
>  
> The long-term solution probably involves adding a function pointer member
> field for each machine description with a generic, default function that
> does something akin to the above board-specific approach.
> 
> Comments welcomed.

Maybe ask about that on LKML and LAKML? There may be some rtc related
changes queued up too..

Tony
