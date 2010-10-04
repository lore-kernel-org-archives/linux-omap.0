From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 4 Oct 2010 18:22:54 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC47@dbde02.ent.ti.com>
References: <20101002004821.GN3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
 <AANLkTim_x=AykoGMZkHTPpXkX=6k+QA04VetqY56c57G@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC09@dbde02.ent.ti.com>
 <AANLkTikMmqe0ozTLY5qc8O3k=_vLAa1n2PB7cYsrEuR7@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC13@dbde02.ent.ti.com>
 <AANLkTikTmBxjRfy-0Ks_iJk2O7+jMYoKk6WChyO21wDW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41943 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0JDMxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 08:53:05 -0400
In-Reply-To: <AANLkTikTmBxjRfy-0Ks_iJk2O7+jMYoKk6WChyO21wDW@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com] 
> Sent: Monday, October 04, 2010 6:03 PM
> To: G, Manjunath Kondaiah
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: NOTE: hwmod changes merged to linux-omap master 
> for testing
> 
> On Mon, Oct 4, 2010 at 2:20 PM, G, Manjunath Kondaiah 
> <manjugk@ti.com> wrote:
> > Can you post complete boot log? so far, it failed on one 
> blaze and one 
> > 3430sdp both of them are having es2.0
> 
> Sure:
> 
> wizery.com/ohad/blaze-linux-omap.txt.gz

Here is difference: you are booting with nosmp..

console=ttyO2,115200n8 root=/dev/nfs rw rootdelay=1 mem=460M@0x80000000 mem=512M@0xA0000000 noinitrd vram=12M omapfb.vram=0:5M,1:5M nosmp nfsroot=192.168.1.4:/home/ohad/embedded/myfs_blaze,nolock,devfs=mount ip=192.168.1.160

Remove nosmp from your bootargs and try.

-Manjunath


