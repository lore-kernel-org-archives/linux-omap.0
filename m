From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [PATCH 04/10 v1] arm: omap: usb: create common enums and
 structures for ehci and ohci
Date: Tue, 1 Mar 2011 17:01:31 +0530
Message-ID: <ee4f0a3aed348a1ce99c0a35deac07e4@mail.gmail.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-2-git-send-email-keshava_mgowda@ti.com> <1298910712-2051-3-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-4-git-send-email-keshava_mgowda@ti.com> <1298910712-2051-5-git-send-email-keshava_mgowda@ti.com>
 <20110301104940.GS2942@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49337 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756124Ab1CALbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 06:31:39 -0500
In-Reply-To: <20110301104940.GS2942@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>, Partha Basak <p-basak2@ti.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Tuesday, March 01, 2011 4:20 PM
> To: Keshava Munegowda
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; balbi@ti.com;
gadiyar@ti.com; p-
> basak2@ti.com
> Subject: Re: [PATCH 04/10 v1] arm: omap: usb: create common enums and
structures for ehci and ohci
>
> On Mon, Feb 28, 2011 at 10:01:46PM +0530, Keshava Munegowda wrote:
> > Create the ehci and ohci specific platform data structures.
> > The port enum values are made common for both ehci and ohci.
> >
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>
> Applying: arm: omap: usb: create common enums and structures for ehci
and ohci
> error: patch failed: drivers/usb/host/ehci-omap.c:409
> error: drivers/usb/host/ehci-omap.c: patch does not apply
> Patch failed at 0005 arm: omap: usb: create common enums and structures
for ehci and ohci
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".
>
> Which tree did you use as base for these patches ? I'm trying to apply
> on top of v.2.6.38-rc6

I will check this and send the rebased patches to you in next 2 hrs.


>
> --
> balbi
