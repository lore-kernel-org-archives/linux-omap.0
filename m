From: Tony Lindgren <tony@atomide.com>
Subject: Re: SRAM - power management
Date: Mon, 13 Oct 2014 08:58:10 -0700
Message-ID: <20141013155810.GB5192@atomide.com>
References: <CAJ2oMh+V8AJ1ryfCoUUOCJ3xAyW2c6RQiZ705Zv1KVoF4jMbWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754102AbaJMP7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2014 11:59:25 -0400
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+V8AJ1ryfCoUUOCJ3xAyW2c6RQiZ705Zv1KVoF4jMbWQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [141012 00:29]:
> Hello,
> 
> What happens to SRAM when omap gets into retention ? Does it need a
> speciasl treatment ?

The SRAM stays in self-refresh. AFAIK mainline Linux does not yet
have partial array RAM refresh support.

Regards,

Tony
