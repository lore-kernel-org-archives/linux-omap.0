From: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Subject: Re: OMAP2420-HS flashing question
Date: Mon, 19 Oct 2009 20:05:27 +0200
Message-ID: <4ADCAA67.3020707@nt.tu-darmstadt.de>
References: <4ADCA2BF.3020105@globalautomationsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:33267 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbZJSSQy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 14:16:54 -0400
In-Reply-To: <4ADCA2BF.3020105@globalautomationsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrejs Cainikovs <andrejsc@globalautomationsystems.com>
Cc: linux-omap@vger.kernel.org

Andrejs Cainikovs wrote:
> Dear all,
>
> I've googled that OMAP HS are checking some kind of signature (applications should be signed with the special tool
> (OST Tools)) so the developer must own the keys for particular CPU? It is possible to turn off the HS option so I'll
> be able to work with non-signed binaries? The problem is that I want to get kernel running on custom OMAP2420-HS
> board but have no keys.

no, it cannot be turned off, that would somehow counteract the "high" part in "high security"

> If somebody can send me the OMAP2420 HS (or similar) datasheet, I'll really appreciate that.

hehe, nice try... :-)

