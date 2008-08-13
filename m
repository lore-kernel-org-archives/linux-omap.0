From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP AIC23
Date: Wed, 13 Aug 2008 08:41:30 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A870D5F0FD9@dlee01.ent.ti.com>
References: <65e025470808111221w43dad825jf237ce6c0e89bdde@mail.gmail.com>
 <01ae01c8fc3c$fe070790$LocalHost@wipultra806>
 <7B4574D56E4ADF438756313E9A172A870D5F0E4D@dlee01.ent.ti.com>
 <001001c8fd0f$20620290$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:55758 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbYHMNlx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 09:41:53 -0400
In-Reply-To: <001001c8fd0f$20620290$LocalHost@wipultra806>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shekhar, Chandra" <x0044955@ti.com>, Yuri Jaeger Monti <yurijm@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Look like this should be doable.
> but we will have two read/write defs in header. one will be Macro and
> other will
> be function, both mapping to same code.


Correct. As well as moving the macro definition, I did add a prototype for the read and write function to the header too. Check out the patch I submitted. Compiling fine now for me.

Cheers
Jon
