From: "Christensen, Mikkel" <mlc@ti.com>
Subject: RE: LDP broken in 2.6.30-rc 2
Date: Tue, 21 Apr 2009 15:05:53 +0200
Message-ID: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7E09@dnce01.ent.ti.com>
References: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7960@dnce01.ent.ti.com>
 <3CE4B6F2-371C-443E-B010-1A05694037C1@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47056 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbZDUNGF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 09:06:05 -0400
In-Reply-To: <3CE4B6F2-371C-443E-B010-1A05694037C1@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On 2.6.29 I can use NFS and the board will boot my file system. On the 2.6.30-rc 2 the board is not even coming this far.

Best regards,
Mikkel

-----Original Message-----
From: Koen Kooi [mailto:k.kooi@student.utwente.nl] 
Sent: Tuesday, April 21, 2009 2:31 AM
To: Christensen, Mikkel
Cc: linux-omap@vger.kernel.org
Subject: Re: LDP broken in 2.6.30-rc 2


Op 20 apr 2009, om 22:28 heeft Christensen, Mikkel het volgende  
geschreven:


> I cloned master a few days ago and when I boot up the OMAP3 LDP, the  
> board seem to hang in the "i2c /dev entries driver" dialog and after  
> a minute the kernel dumps. Have anybody else seen this problem?

LDP was broken in .29 as well, at least for mmc: http://patchwork.kernel.org/patch/15340/

regards,

Koen
