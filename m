From: Brian Hutchinson <b.hutchman@gmail.com>
Subject: Re: OMAP gpiolib?
Date: Wed, 1 Jun 2011 10:48:57 -0400
Message-ID: <BANLkTikorKre_Z0kYGJzJneF_genurY+aQ@mail.gmail.com>
References: <BANLkTikpOeH_xXLtdrmuN4KJcrdgONcP2A@mail.gmail.com>
	<8762opk48z.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40015 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875Ab1FAOs6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 10:48:58 -0400
Received: by bwz15 with SMTP id 15so114230bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Jun 2011 07:48:57 -0700 (PDT)
In-Reply-To: <8762opk48z.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Thanks Kevin!

The TI PSP04.00.00.10 release notes say the 2.6.37 kernel has gpio lib
support added.  The previous version of the same kernel that was part
of the previous PSP (4.00.00.09 I think) had the same kernel but
apparently gpiolib was there but wasn't quite all there for the
c6a816x.

Just wanted to make sure using hardware spi master and gpio spi master
was a valid setup and didn't require special magic.  I know how to
setup the pin mux but I didn't know if there was anything else special
I should be aware of.  I'm not aware of any boards in arch that
require a setup similar to ours we could look at as an example.

Regards,

Brian
