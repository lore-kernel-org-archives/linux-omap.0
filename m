From: Tapani Utriainen <tapani@technexion.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Fri, 29 Jul 2011 09:44:39 +0800
Message-ID: <20110729094439.74156e05@myhost>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
	<20110728132629.GH9069@legolas.emea.dhcp.ti.com>
	<CAACX+R0-vUP1z9DoS69iv2gX=YCKanousEHATzot0sSi-S9cEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from technexion.com ([72.51.46.185]:41414 "EHLO technexion.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436Ab1G2Bnq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 21:43:46 -0400
In-Reply-To: <CAACX+R0-vUP1z9DoS69iv2gX=YCKanousEHATzot0sSi-S9cEQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: linux-omap@vger.kernel.org

On Thu, 28 Jul 2011 16:18:51 +0200
Arno Steffen <arno.steffen@googlemail.com> wrote:

> That has been good points. I've tried both, but with no result so far.
> 

Try appending earlyprintk=${console} to your bootargs (where ${console}
is your console string, e.g. ttyO0,115200n8 )

---
Tapani Utriainen, PhD
Senior Software Engineer
TechNexion Ltd, www.technexion.com

