From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Thu, 29 Mar 2012 11:42:34 +0530
Message-ID: <4F73FD52.60209@ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com> <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:56580 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753706Ab2C2GMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 02:12:42 -0400
Received: by obbeh20 with SMTP id eh20so2409395obb.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 23:12:41 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wednesday 28 March 2012 12:02 PM, Hiremath, Vaibhav wrote:
> On Tue, Mar 27, 2012 at 15:28:31, Nayak, Rajendra wrote:
>> Some functions like _omap4_disable_module() and _omap4_wait_target_disable()
>> are (will be) used on all OMAPs OMAP4 and beyond which support module level
>> control. Fix the error checks in these functions to return if called on
>> any platform pre OMAP4 (i.e OMAP2 and OMAP3) instead of checking for
>> !cpu_is_omap44xx(). This avoids having to update the error check with a
>> '&&  !cpu_is_omap54xx()' when OMAP5 is introduced and possibly similar updates
>> when further OMAP generations are added.
>>
>
> Let me add some flavor here :)
>
> AM33xx, which has module level control, but falls under OMAP3 family of
> devices. cpu_is_omap34xx() is true for AM33xx device and we have to add
> check in all these functions. And I am sure we will have many of such
> devices in the future.
>
> Can we use some flag based option here, instead of cpu_is_xxx() check?
>

The intent of this patch was to make the error handling uniform across
all modules control functions in hwmod, and it atleast addresses one
problem of having to update these checks every time a new OMAP gets
added.

The problem that you bring up with AM33xx is regardless of this patch
(you would still need to go update every !cpu_is_omap44xx() check)
and IMHO should be handled separately, with a flag like you are
suggesting or by some other means. If you already have patches on how
this can be done, you should go ahead and post them out.
