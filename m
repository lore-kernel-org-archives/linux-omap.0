From: Luke Dashjr <luke@dashjr.org>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Tue, 12 May 2009 18:18:13 -0500
Message-ID: <200905121818.13785.luke@dashjr.org>
References: <200905091745.06435.luke@dashjr.org> <20090512100658.86a99e98.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wsip-70-184-212-11.om.om.cox.net ([70.184.212.11]:46630 "EHLO
	hachi.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZELXSY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 19:18:24 -0400
In-Reply-To: <20090512100658.86a99e98.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 12 May 2009 02:06:58 am Jarkko Nikula wrote:
> On Sat, 9 May 2009 17:45:00 -0500
>
> "Luke-Jr" <luke@dashjr.org> wrote:
> > Having trouble getting "2.6.30-rc4-omap1" to boot my US N810 (running
> > Gentoo). The initial problem appears to be related to /dev/mmcblk*
> > missing, but I can't debug it very far due to the second problem I
>
> For me mmc is working. I'm booting through the modified initfs with
> official major number 179 for /dev/mmcblk* device nodes.

Modified initfs? Is there something needed beyond copying the filesystem's 
modules?

Luke
