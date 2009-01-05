From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: git clone through http not working well
Date: Mon, 5 Jan 2009 14:37:23 -0600
Message-ID: <A24693684029E5489D1D202277BE89441623BB98@dlee02.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A871FCB5465@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34496 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZAEUhb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2009 15:37:31 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n05KbPho009230
	for <linux-omap@vger.kernel.org>; Mon, 5 Jan 2009 14:37:30 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n05KbPSH019030
	for <linux-omap@vger.kernel.org>; Mon, 5 Jan 2009 14:37:25 -0600 (CST)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A871FCB5465@dlee01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ok, I retried it with corkscrew, but the issue is now different...

I'm having this:

saaguirre@x0091359-linux:~$ git clone git://source.mvista.com/git/linux-omap-2.6.git linux-omap-2.6-newer2
Initialized empty Git repository in /home/saaguirre/linux-omap-2.6-newer2/.git/
fatal: The remote end hung up unexpectedly

UPDATE: Just before I sent this message, I saw Koen Kooi suggestion to use main repo instead of mvista copy: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

And it seems that is working now well :)

So I guess it's a problem with mvista copy then... :/

Thanks all for your help!

Regards,
Sergio

> -----Original Message-----
> From: Hunter, Jon
> Sent: Monday, January 05, 2009 2:23 PM
> To: Aguirre Rodriguez, Sergio Alberto; linux-omap@vger.kernel.org
> Subject: RE: git clone through http not working well
> 
> Hi Sergio,
> 
> > I was trying to clone the git tree using http protocol,
> > because git protocol is blocked by my network firewall, and I
> > got this after a while:
> 
> 
> I have not seen this issue, but I have been using corkscrew so that I can
> use the git protocol behind a firewall. For more details on using
> corkscrew see:
> 
> http://wiki.omap.com/index.php?title=Git#Using_Git_Behind_a_Firewall
> 
> Cheers
> Jon
