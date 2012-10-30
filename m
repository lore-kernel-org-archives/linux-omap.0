From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 13:03:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301259250.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com> <508F59FB.7080400@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48122 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651Ab2J3NDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 09:03:34 -0400
In-Reply-To: <508F59FB.7080400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 30 Oct 2012, Vaibhav Hiremath wrote:

> On 10/30/2012 8:06 AM, Paul Walmsley wrote:
>
> > * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >   - Due to GPMC missing support for DT
> >   - Temporary workaround at http://www.spinics.net/lists/arm-kernel/msg200787.html
> >   - May be fixed now, pending retest:
> >     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
> > 
> 
> This is surprising, I have tested v3.7-rc3 branch on AM335xBone platform
> and its booting up for me without any issues.
> Jon had submitted another patch which fixes boot issue on Bone.
> 
> https://patchwork.kernel.org/patch/1606471/

Please don't worry about this one at the moment.  This one isn't part of 
the automated test suite, so it requires further effort from me to 
re-test.  I've marked it as such in the README.  Will try to re-test by 
v3.7-rc4.


- Paul
