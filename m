From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: USB on omap2430
Date: Tue, 30 Mar 2010 00:04:51 -0500
Message-ID: <e7605e24d5eafb39554667371c59b1be@secure211.sgcpanel.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>,
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>,
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com> <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com> <3821c76c47d164935b857a29de6bb797@secure211.sgcpanel.com> <70376CA23424B34D86F1C7DE6B997343023C4E1FE6@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55996 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0C3FEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 01:04:51 -0400
In-Reply-To: <70376CA23424B34D86F1C7DE6B997343023C4E1FE6@VSHINMSMBX01.vshodc.lntinfotech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viral Mehta <Viral.Mehta@lntinfotech.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, 30 Mar 2010 10:07:30 +0530, Viral Mehta
<Viral.Mehta@lntinfotech.com> wrote:
>>
>> to me it sounds like you don't have a transceiver. Can you do the
>> following:
> 
> I thought when you said transceiver is not present, you meant that
> transceiver as
> HW (or chip) is not present. 

I meant the driver :-)

>> 1. arm-linux-gdb vmlinux (with the same kernel image you reproduce the
>> crash)
>> 2. (gdb) l *(musb_platform_suspend + 0x20)
>>
>> it should show you the source code and the line number from
>> where the NULL pointer comes
> 
> I did that but uImage had not symbol information and thus it did not
give
> exact information.

that's why I used vmlinux, see the command up there ?

-- 
balbi
