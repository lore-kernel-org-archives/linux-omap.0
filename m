From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Fri, 30 Mar 2012 07:14:52 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831840CE9@DBDE01.ent.ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
 <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com>
 <4F73FD52.60209@ti.com>
 <79CD15C6BA57404B839C016229A409A83183FB9F@DBDE01.ent.ti.com>
 <4F7479B5.5060401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47459 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab2C3HPA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 03:15:00 -0400
In-Reply-To: <4F7479B5.5060401@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 29, 2012 at 20:33:17, Hunter, Jon wrote:
> Hi Viabhav,
> 
> On 3/29/2012 3:56, Hiremath, Vaibhav wrote:
> > On Thu, Mar 29, 2012 at 11:42:34, Nayak, Rajendra wrote:
> >> On Wednesday 28 March 2012 12:02 PM, Hiremath, Vaibhav wrote:
> >>> On Tue, Mar 27, 2012 at 15:28:31, Nayak, Rajendra wrote:
> >>>> Some functions like _omap4_disable_module() and _omap4_wait_target_disable()
> >>>> are (will be) used on all OMAPs OMAP4 and beyond which support module level
> >>>> control. Fix the error checks in these functions to return if called on
> >>>> any platform pre OMAP4 (i.e OMAP2 and OMAP3) instead of checking for
> >>>> !cpu_is_omap44xx(). This avoids having to update the error check with a
> >>>> '&&   !cpu_is_omap54xx()' when OMAP5 is introduced and possibly similar updates
> >>>> when further OMAP generations are added.
> >>>>
> >>>
> >>> Let me add some flavor here :)
> >>>
> >>> AM33xx, which has module level control, but falls under OMAP3 family of
> >>> devices. cpu_is_omap34xx() is true for AM33xx device and we have to add
> >>> check in all these functions. And I am sure we will have many of such
> >>> devices in the future.
> >>>
> >>> Can we use some flag based option here, instead of cpu_is_xxx() check?
> >>>
> >>
> >> The intent of this patch was to make the error handling uniform across
> >> all modules control functions in hwmod, and it atleast addresses one
> >> problem of having to update these checks every time a new OMAP gets
> >> added.
> >>
> >> The problem that you bring up with AM33xx is regardless of this patch
> >> (you would still need to go update every !cpu_is_omap44xx() check)
> >
> > Indeed, in any of cpu_is_xxx() check implementation, I have to add check
> > for cpu_is_am33xx().
> 
> I hope we can avoid adding more cpu_is_amXXXX. That should be a last resort.
> 

Yes, indeed; adding cpu_is_xxx check would be my last option.

Thanks,
Vaibhav

> Jon
> 

