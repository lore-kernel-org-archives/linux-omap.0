From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: McSPI3 on the BeagleBoard
Date: Fri, 20 Feb 2009 13:44:32 +0200
Message-ID: <6ed0b2680902200344r2419760ey29cea09c3200482a@mail.gmail.com>
References: <499B4B64.30109@balister.org>
	 <200902171918.45146.david-b@pacbell.net>
	 <499CAA27.5020500@balister.org> <1235031747.13828.1.camel@localhost>
	 <499D694A.8000404@balister.org> <1235118800.6894.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:36629 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZBTLoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 06:44:34 -0500
Received: by bwz5 with SMTP id 5so2407059bwz.13
        for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 03:44:32 -0800 (PST)
In-Reply-To: <1235118800.6894.18.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregoire@gentil.com
Cc: Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> - MUX setup for USB ehci has never worked in the kernel. It's why the
> beagleaboard rev-C ehci patch has been transfered to u-boot.

Do you have CONFIG_OMAP_MUX enabled? It's disabled in beagle's defconfig.
