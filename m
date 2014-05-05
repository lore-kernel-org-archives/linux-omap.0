From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
Date: Mon, 5 May 2014 17:02:40 +0300
Message-ID: <53679A00.70803@ti.com>
References: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com> <alpine.DEB.2.02.1402191752590.8777@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42444 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbaEEODY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 10:03:24 -0400
In-Reply-To: <alpine.DEB.2.02.1402191752590.8777@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Illia Smyrnov <illia.smyrnov@globallogic.com>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com

Hi Illia,

On 02/19/2014 07:53 PM, Paul Walmsley wrote:
> On Wed, 5 Feb 2014, Illia Smyrnov wrote:
> 
>> Commit 313a76e (ARM: OMAP2+: hwmod: Fix SOFTRESET logic) introduced
>> softreset bit cleaning right after set one. It is caused L3 error for
>> OMAP4 ISS because ISS register write occurs when ISS reset process is in
>> progress. Avoid this situation by cleaning softreset bit later, when reset
>> process is successfully finished.
>>
>> Signed-off-by: Illia Smyrnov <illia.smyrnov@globallogic.com>
> 
> Thanks, queued for v3.14-rc with notations from Grygorii and Roger.
> 

This hasn't made it to the stable kernels yet.

Could you please send commit 01142519ffc0 to stable@vger.kernel.org for
v3.4+ kernels? Thanks.

cheers,
-roger

