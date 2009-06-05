From: "Curran, Dominic" <dcurran@ti.com>
Subject: RE: Script for applying a set of patches from a folder
Date: Fri, 5 Jun 2009 09:06:36 -0500
Message-ID: <96DA7A230D3B2F42BA3EF203A7A1B3B50139D244E1@dlee07.ent.ti.com>
References: <200906051549.56878.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60030 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbZFEOId convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 10:08:33 -0400
In-Reply-To: <200906051549.56878.jpihet@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>, Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>



 On Friday 05 June 2009 12:55:41 Elvis Dowson wrote:
> > HI,
> >     Does anyone have a script that will allow me to apply all the patches
> > that are contained in a folder, using the git apply command?
> You need to use git am for that, with the dir as parameter. git am will apply
> each patch from the dir.

If they are in a quilt series then you can use:
$ git quiltimport

