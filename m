From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 15/16] OMAP4: hwmod data: Fix typo and alignement
Date: Thu, 23 Jun 2011 22:26:07 +0200
Message-ID: <4E03A15F.4020205@ti.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com> <1308851025-26313-16-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932755Ab1FWU0L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 16:26:11 -0400
In-Reply-To: <1308851025-26313-16-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Some comments to myself...

On 6/23/2011 7:43 PM, Cousson, Benoit wrote:
> Fix a typo in the mailbox description comment.
In fact the typo was already fixed and that patch is re-introducing it :-(

[...]

>   /*
>    * 'mailbox' class
> - * mailbox module allowing communication between the on-chip processors using a
> - * queued mailbox-interrupt mechanism.
> + * mailbox module allowing communication between the on-chip processors
> + * useusing a queued mailbox-interrupt mechanism.
>    */

I'll update the series and fix the subject.

Benoit
