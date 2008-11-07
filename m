From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: 3430SDP crash at boot time
Date: Fri, 7 Nov 2008 08:09:26 -0600
Message-ID: <A24693684029E5489D1D202277BE894413A9499B@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894413A94881@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0811070458390.13920@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYKGOJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 09:09:34 -0500
In-Reply-To: <alpine.DEB.2.00.0811070458390.13920@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

I'm attempting this with a 3430SDP-VG5.0.1 (ES3.0), and I was using the same commit.

I'll retry today with another board, to see if it helps.

Thanks for your time.

Regards,
Sergio

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Friday, November 07, 2008 6:00 AM
To: Aguirre Rodriguez, Sergio Alberto
Cc: linux-omap@vger.kernel.org
Subject: Re: 3430SDP crash at boot time

On Thu, 6 Nov 2008, Aguirre Rodriguez, Sergio Alberto wrote:

> Today when I attempted to boot on an 3430SDP with latest commit, I got a kernel dump, which is this:

> PC is at cfi_qry_present+0x1c0/0x29c

f7429fd378a29cf6947c2613e0fd6e6e36165167 boots fine now on the 3430SDP 
ES2 that I use here.  What commit is your git head at, and what ES level 
is your 3430SDP using?


- Paul

