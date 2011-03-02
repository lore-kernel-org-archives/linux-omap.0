From: archit taneja <archit@ti.com>
Subject: Re: [PATCH v2 0/3]OMAP: DSS2: Abstract away DSI VC information from
 dsi panel drivers
Date: Wed, 2 Mar 2011 11:10:35 +0530
Message-ID: <4D6DD853.7050707@ti.com>
References: <1298982743-6771-1-git-send-email-archit@ti.com> <1298995002.2049.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52423 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBFho (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 00:37:44 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p225bfTC001833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 23:37:43 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p225bejc008139
	for <linux-omap@vger.kernel.org>; Wed, 2 Mar 2011 11:07:40 +0530 (IST)
In-Reply-To: <1298995002.2049.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 01 March 2011 09:26 PM, Valkeinen, Tomi wrote:
> On Tue, 2011-03-01 at 06:32 -0600, Taneja, Archit wrote:
>> The current DSI driver design requires the DSI panel driver to specify the
>> DSI Virtual Channel and the Panel Virtual Channel ID for the transfer of
>> commands and frame data. Out of these, only the second parameter is a property
>> of the Panel.
>>
>> The DSI Virtual Channel in use by the panel driver ideally shouldn't be provided
>> by the panel driver. The current design leads to the following issues:
>> -Multiple panels connected to the same DSI interface would be unaware of the
>> VC's in use.
>> -Hard coded Virtual Channel numbers in panel drivers which is not generic.
>> -No clean way of configuring DSI for panels which need atleast 2 DSI Virtual
>> Channels.
>> -No clean way of configuring DSI for the special case where a panel may have 2
>> or VC ID's corresponding to it.
>>
>> The panel driver should, instead, request for, and release DSI Virtual Channels
>> through calls to the DSI driver. The DSI driver should return VC numbers which
>> the panel can use. The panel driver then uses this VC to either send pixel data,
>> send commands and receive data from the panel. The DSI driver then automatically
>> configures the Virtual Channel source to either Video Port or L4 Slave Port.
>>
>> This patch set tries to achieve the above design, and make Panel Taal driver use
>> this approach.
>
> This patch set doesn't apply, and seems not to be based on Linus',
> Tony's or my tree. What is it based on?
>

This is based on your master with a few patches I posted on l-o before 
which haven't been applied yet. I will make sure I mention the pending 
patches required when I post the next version.

Archit

> You should always base the patches on top of a public tree before
> sending the patches. Otherwise it is difficult to apply those patches.
> Or clearly say the required patch sets, which have previously been sent
> for review, but not yet applied.
>
>   Tomi
>
>

