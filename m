From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Script for applying a set of patches from a folder
Date: Fri, 5 Jun 2009 15:10:24 +0300
Message-ID: <20090605121024.GC11591@nokia.com>
References: <3284AAA8-73B9-4C4C-95FD-29BC92AFE5A8@mac.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56662 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbZFEMNj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 08:13:39 -0400
Content-Disposition: inline
In-Reply-To: <3284AAA8-73B9-4C4C-95FD-29BC92AFE5A8@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

On Fri, Jun 05, 2009 at 12:55:41PM +0200, ext Elvis Dowson wrote:
> HI,
> 	Does anyone have a script that will allow me to apply all the patches  
> that are contained in a folder, using the git apply command?
> 
> I have hundreds of patches that I want to apply from the dss2 and pm  
> branches to the linux-omap-2.6 branch, locally, to bring it upto date,  
> to a known state before making specific patches for the overo platform.

if they are in mbox format you use git am /path/to/patches/*

-- 
balbi
