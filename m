From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
Date: Mon, 31 Mar 2008 19:51:38 -0500
Message-ID: <20080401005137.GA22520@ubuntu-workstation>
References: <20080331014640.GA14188@ubuntu-workstation> <47F14D61.5030109@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:56886 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYDAAyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 20:54:15 -0400
Received: by py-out-1112.google.com with SMTP id u52so2700795pyb.10
        for <linux-omap@vger.kernel.org>; Mon, 31 Mar 2008 17:54:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47F14D61.5030109@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 31, 2008 at 11:45:21PM +0300, Francisco Alecrim wrote:
> Hello Seth,
>    It's fine and work for 3430! Maybe you should resend changing the 
> commit message. It's too big.
> 
> Remove "RFC" from subject.
> 
> What do you think?
> 
> if(changes)
>    Acked-by: Francisco Alecrim <francisco.alecrim@indt.org.br>

Thank you for reviewing/testing.  I wanted to get verification for OMAP3430
before I officially submitted the patch, and since you have done that I will
submit it now.
