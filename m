From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 0/5] OMAP4: mux: Add the OMAP4430 ES1 support
Date: Mon, 18 Oct 2010 22:51:42 +0200
Message-ID: <4CBCB35E.9080502@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <7A436F7769CA33409C6B44B358BFFF0C014FAB2762@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57362 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab0JRUvp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Oct 2010 16:51:45 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9IKpi90001715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 15:51:44 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o9IKpitr013942
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 15:51:44 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9IKpi28012030
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 15:51:44 -0500 (CDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014FAB2762@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Nishanth,

On 10/18/2010 8:09 PM, Menon, Nishanth wrote:
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Benoit Cousson
>>
> Ping? Is there a possibility for a v2 non-rfc ES2 support?

And what about a RFC v2? With ES2 support of course :-)

The changes I have done are breaking RX51 support due to the usage of 
low-level API from the mux code.

For the moment I just disabled that code from the RX51, so there is no 
way I send that except in a RFC form :-(

Regards,
Benoit
