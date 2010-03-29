From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: USB on omap2430
Date: Mon, 29 Mar 2010 23:34:10 +0300
Message-ID: <20100329203410.GA31402@nokia.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
 <3821c76c47d164935b857a29de6bb797@secure211.sgcpanel.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37357 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab0C2Uev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 16:34:51 -0400
Content-Disposition: inline
In-Reply-To: <3821c76c47d164935b857a29de6bb797@secure211.sgcpanel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: Viral Mehta <Viral.Mehta@lntinfotech.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Mar 26, 2010 at 06:44:16PM +0100, ext Felipe Balbi wrote:
>to me it sounds like you don't have a transceiver. Can you do the
>following:
>
>1. arm-linux-gdb vmlinux (with the same kernel image you reproduce the
>crash)
>2. (gdb) l *(musb_platform_suspend + 0x20)
>
>it should show you the source code and the line number from
>where the NULL pointer comes
>
>ps: please read http://elinux.org/Netiquette

any news on this ?

-- 
balbi
