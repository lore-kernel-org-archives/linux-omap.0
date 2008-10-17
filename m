From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: dpll4_ck rate broken
Date: Fri, 17 Oct 2008 15:09:54 +0300
Message-ID: <1224245394.19051.14.camel@tubuntu>
References: <1224241708.19051.6.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61358 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbYJQMKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 08:10:37 -0400
In-Reply-To: <1224241708.19051.6.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, paul@pwsan.com

On Fri, 2008-10-17 at 14:08 +0300, ext Tomi Valkeinen wrote:
> Hi,
> 
> With latest linux-omap kernel, the dpll4_ck rate is a bit funny:
> 
> ~ # cat /debug/clock/virt_26m_ck/osc_sys_ck/sys_ck/rate 
> 13000000
> 
> ~ # cat /debug/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll4_ck/rate 
> 3224773576
> 

The reason seems to be in arch/arm/mach-omap2/clock34xx.c:
omap3_noncore_dpll_enable(). It sets the dpll4_ck rate to the value of
an unassigned local variable 'rate'.

 Tomi


