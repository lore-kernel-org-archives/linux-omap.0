From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Tue, 14 Feb 2012 19:00:23 +0530
Message-ID: <4F3A61EF.4030803@ti.com>
References: <1328854552-30714-1-git-send-email-archit@ti.com>  <1329220678.1845.68.camel@deskari>  <4F3A5A5D.4020906@ti.com> <1329225311.1845.109.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab2BNNaf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 08:30:35 -0500
In-Reply-To: <1329225311.1845.109.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

Hi,

On Tuesday 14 February 2012 06:45 PM, Tomi Valkeinen wrote:
> On Tue, 2012-02-14 at 13:58 +0100, Cousson, Benoit wrote:
>> Hi Tomi,
>
>>> Benoit, do you think we'll get the MODULEMODE mess cleaned up in the
>>> hwmod/clk framework at some point, and the drivers could do without
>>> these kinds of hacks? =)
>>
>> The best way to fix that for my point of view is to go to device tree
>> or/and to consider the DSS as the parent of all the DSS modules.
>> pm_runtime will then always ensure that the parent is enabled before any
>> of the child are used.
>
> Ah, right. Sounds fine to me.
>
> But is that a proper "fix"? Are we sure the MODULEMODE will then always
> be handled correctly? Isn't the core problem still there, it just
> doesn't happen with the setup anymore?
>
> I mean, if we have these special requirements regarding MODULEMODE, and
> the code doesn't really know about it, would it get broken easily with
> restructuring/changes?
>
> And no, I don't have any clear idea why/how it would break, but I have
> just gotten the impression that the MODULEMODE is not handled quite
> properly (and so we have these current problems), and having dss_core as
> the parent of other dss modules doesn't really fix that in any way.

I agree with that.

In the current approach, we have multiple platform devices for DSS, and 
all of them belong to the same clock domain, and the clock domain has 
just one MODULEMODE bit field.

When shutting off a platform device(by calling pm_runtime_put()), hwmod 
enables/disables MODULEMODE without taking into mind that other active 
platform devices may still need it. So, for example, if we have 2 
platform devices, say dss and dispc, and we have code like:

dispc_foo()
{
	pm_runtime_get(dispc_pdev);
		...
		...
	pm_runtime_put(dispc_pdev);
}

dss_foo()
{
	pm_runtime_get(dss_pdev);
		...
		...
		dispc_foo(); /* MODULEMODE off after this */
		...
		...
	pm_runtime_put(dss_pdev);
}

This will lead to the situation of one platform device disabling 
MODULEMODE even though other platform devices need it.

This may not be resolved in device tree either. We would need to have 
some use count mechanism for these bits, or attach MODULEMODE only to 
one platform device, and don't give others control to enable/disable it.

Archit
