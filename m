From: "Stehle, Vincent" <v-stehle@ti.com>
Subject: RE: OMAP Audio
Date: Fri, 26 Feb 2010 11:09:45 +0100
Message-ID: <470B922D8A441644AAD7CE6FE610ADEBCF1DC795@dnce01.ent.ti.com>
References: <4B7AE1AD.7080400@mlbassoc.com>
 <201002171226.05108.peter.ujfalusi@nokia.com>
 <4B7BC86C.8040905@mlbassoc.com>
 <201002171317.27896.peter.ujfalusi@nokia.com>
 <4B7BDAB1.3020503@mlbassoc.com> <20100217194501.7e49ac0c.jhnikula@gmail.com>
 <4B7C2C8F.9040703@mlbassoc.com> <20100217175602.GG2032@sirena.org.uk>
 <4B7C2F11.3010008@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40283 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab0BZKJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 05:09:55 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <4B7C2F11.3010008@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

Gary Thomas:
> I don't think it matters.  The real problem is how to get 24 bits
> of data aligned to the right place in the 32 bit frame.  TRM implies
> that the hardware can do this, I've just not figured out the magic...

Hi,

I asked a colleague, who worked on OMAP3 McBSP silicon validation. She =
told me that in your case, you will need to send 32 bits of data and th=
at you will have to pad your data beforehand in software.

Best regards,

--
Vincent Stehl=E9

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Lo=
ubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
