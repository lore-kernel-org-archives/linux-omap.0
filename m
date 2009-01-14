From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP3430 clock settings
Date: Wed, 14 Jan 2009 10:11:15 -0800
Message-ID: <200901141011.15673.david-b@pacbell.net>
References: <1231897985-5274-1-git-send-email-stanley.miao@windriver.com> <3a2dabf50901140100i63899449ud8fee54bd7763bff@mail.gmail.com> <F9F1042FDECC134ABFBF4EC5EBEC88DAB357EF@EXGZ02.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:29306 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753910AbZANSLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2009 13:11:17 -0500
In-Reply-To: <F9F1042FDECC134ABFBF4EC5EBEC88DAB357EF@EXGZ02.sasken.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Krishna Kishore <krishna.kishore@sasken.com>
Cc: Ramesh Gupta Guntha <grgupta77@gmail.com>, linux-omap@vger.kernel.org

On Wednesday 14 January 2009, Krishna Kishore wrote:
>=20
> =A0 =A0After reading IVA2_CM and MPU_CM registers, I want to know how=
 to
> calculate the clock speeds.

You should be using the clock framework.  If you do that,
then clk_get_rate() does that for you.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
