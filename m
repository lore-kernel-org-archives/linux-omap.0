From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from plat-omap to mach-omap
Date: Mon, 14 Apr 2008 16:11:30 -0400
Message-ID: <1208203891-11225-1-git-send-email-edubezval@gmail.com>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47792 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbYDNUPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 16:15:39 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3EKF6TP027082
	for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2008 23:15:36 +0300
Received: from knuth.nokia.com (essapo-nirac25231.europe.nokia.com [10.162.252.31])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3EKBTwc015065
	for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2008 23:11:29 +0300
In-Reply-To: <20080414181827.GE4463@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Balbi

On Mon, Apr 14, 2008 at 2:18 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Apr 14, 2008 at 11:53:01AM -0400, Eduardo Valentin wrote:
>  > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  >
>  > This patch gets ride of ifdefs on mcbsp.c code.
>  > It moves the mach specific code to mach-omap*.
>  
>  I don't see the new files here. Did you forgot to git add them?
>  
>  in any case, this is a really good idea ;-)
>  
> 

Here is an updated version of this patch. Probably, I forgot to add them
while creating this patch. Maybe I used git commit -a -s without paying
attention.

Anyway, thanks for pointing that.

Cheers,

Eduardo Valentin


