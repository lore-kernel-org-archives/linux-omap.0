From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and L-Z)
Date: Mon, 23 Feb 2009 20:25:56 +0200
Message-ID: <782515bb0902231025m2e0b6febj2929313db83167f3@mail.gmail.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
	 <1234850560.13109.9.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
	 <1235396273.12653.8.camel@eenurkka-desktop>
	 <49A2D66F.9050809@gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com>
	 <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F71@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:14278 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZBWSZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:25:59 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1557132fkf.5
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 10:25:56 -0800 (PST)
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760036DEC2F71@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-Eero.Nurkkala@nokia.com
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org

On Mon, Feb 23, 2009 at 8:20 PM,  <ext-Eero.Nurkkala@nokia.com> wrote:
>
> Don't just blindly trust the TRM, all that matters is the real signal
> caught in the scope. That is what you want to verify.

;) Aye Aye.... I wonder if the equation you provided is based on
emperical measurement? if so would it vary based on electrical
characteristics of a platform? I mean beagleboard Vs Zoom Vs SDP
atleast have variances of i2c trace lengths and number of devices per
i2c bus.. wont the equation change based on board configuration?

Regards,
Nishanth Menon
