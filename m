From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 5/5] usb: musb: dsps: add support for suspend and resume
Date: Tue, 01 Oct 2013 17:04:04 +0200
Message-ID: <524AE464.3020201@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com> <1380634797-29541-6-git-send-email-zonque@gmail.com> <20131001145919.GZ1476@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:37112 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3JAPEH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Oct 2013 11:04:07 -0400
In-Reply-To: <20131001145919.GZ1476@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com

On 01.10.2013 16:59, Felipe Balbi wrote:
> On Tue, Oct 01, 2013 at 03:39:57PM +0200, Daniel Mack wrote:
>> The dsps platform needs to save save some registers at suspend time and
>> restore them after resume. This patch adds a struct for these registers,
>> and also lets the musb core know that the core registers need to be
>> saved as well.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> this last patch didn't apply. can you rebase on my 'testing' branch ?

I've seen that you already applied the others, so I'm going to resend
only that last one. Hope that's ok.


Daniel

